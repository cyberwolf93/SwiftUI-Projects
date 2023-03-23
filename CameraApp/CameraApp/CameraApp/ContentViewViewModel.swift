//
//  ContentViewViewModel.swift
//  CameraApp
//
//  Created by Ahmed Mohiy on 14/03/2023.
//

import Foundation
import AVFoundation
import Photos

enum CapturePermission {
    case authorized
    case notDetermind
    case denied
}

enum CameraPosition {
    case front
    case back
}

class ContentViewViewModel: NSObject {
    
    let session: AVCaptureSession
    var videoInputDevice: AVCaptureDeviceInput?
    var movieFileOutput: AVCaptureMovieFileOutput?
    var selectedCameraPosition:CameraPosition  = .back
    var capturePermission:CapturePermission = .notDetermind
    let queue = DispatchQueue(label: "AVCaptureSession queue")
    
    override init() {
        self.session = AVCaptureSession()
        super.init()
        queue.async {
            self.requestPermissionToCapture()
        }
    }
    
    func configureSession() {
        
        guard capturePermission == .authorized else {
            print("Not authorized to capture video")
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = .high
        
        var defaultVideoDevice: AVCaptureDevice?
        
        if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
            defaultVideoDevice = dualCameraDevice
        } else if let dualWideCameraDevice = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) {
            // If a rear dual camera is not available, default to the rear dual wide camera.
            defaultVideoDevice = dualWideCameraDevice
        } else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            // If a rear dual wide camera is not available, default to the rear wide angle camera.
            defaultVideoDevice = backCameraDevice
        } else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            // If the rear wide angle camera isn't available, default to the front wide angle camera.
            defaultVideoDevice = frontCameraDevice
        }
        guard let videoDevice = defaultVideoDevice else {
            print("Default video device is unavailable.")
            session.commitConfiguration()
            return
        }
        
        do {
            // Add video input
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoInputDevice = videoDeviceInput
                
            } else {
                session.commitConfiguration()
                return
            }
            
            // add audio input
            let audioDevice = AVCaptureDevice.default(for: .audio)
            let audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice!)
            
            if session.canAddInput(audioDeviceInput) {
                session.addInput(audioDeviceInput)
            } else {
                print("Could not add audio device input to the session")
            }
            
            
            // add movie output
            let movieFileOutput = AVCaptureMovieFileOutput()
            if session.canAddOutput(movieFileOutput) {
                session.addOutput(movieFileOutput)
                self.movieFileOutput = movieFileOutput
                
            } else {
                print("Could not add output moview to the session")
                session.commitConfiguration()
                return
            }
            
        } catch {
            session.commitConfiguration()
            return
        }
        
        
        session.commitConfiguration()
        session.startRunning()
        
    }
    
    // Request recording permission
    func requestPermissionToCapture() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            session.startRunning()
            capturePermission = .authorized
            self.configureSession()
        case .notDetermined:
            queue.suspend()
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.capturePermission = .authorized
                    self.configureSession()
                }
                self.queue.resume()
            }
            
        default:
            capturePermission = .denied
            break
        }
    }
    
    // Change camera front to back and vise versa
    func changeCamera() {
        queue.async {
            
            let backVideoDeviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInDualWideCamera, .builtInWideAngleCamera],
                                                                          mediaType: .video,
                                                                          position: .back)
            
            let frontVideoDeviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInTrueDepthCamera, .builtInWideAngleCamera],
                                                                           mediaType: .video,
                                                                           position: .front)
            
            var newVideoDevice: AVCaptureDevice?
            
            switch self.selectedCameraPosition {
            case .back:
                newVideoDevice = frontVideoDeviceSession.devices.first
                self.selectedCameraPosition = .front
            case .front:
                newVideoDevice = backVideoDeviceSession.devices.first
                self.selectedCameraPosition = .back
            }
            
            if let newVideoDevice {
                do {
                    let videoDeviceInput = try AVCaptureDeviceInput(device: newVideoDevice)
                    self.session.beginConfiguration()
                    if let currentDeviceInput = self.videoInputDevice {
                        self.session.removeInput(currentDeviceInput)
                    }
                    
                    if self.session.canAddInput(videoDeviceInput) {
                        self.session.addInput(videoDeviceInput)
                        self.videoInputDevice = videoDeviceInput
                    } else if let currentDeviceInput = self.videoInputDevice {
                        self.session.addInput(currentDeviceInput)
                    }
                    self.session.commitConfiguration()
                    
                } catch {
                    print("failed to change camera")
                }
            }
        }
    }
    
    
    
    func startRecording() {
        guard let movieFileOutput else {return}
        
        queue.async {

            if !movieFileOutput.isRecording {
                let videoCodecTypes = movieFileOutput.availableVideoCodecTypes
                let videoOutputConnection = movieFileOutput.connection(with: .video)
                
                if let videoOutputConnection, videoCodecTypes.contains(.hevc) {
                    movieFileOutput.setOutputSettings([AVVideoCodecKey: AVVideoCodecType.hevc], for: videoOutputConnection)
                }
                
                let fileName = UUID().uuidString
                let filePath = FileManager.default.temporaryDirectory.appendingPathComponent(fileName, conformingTo: .mpeg2Video).appendingPathExtension("mov")
                
                movieFileOutput.startRecording(to: filePath, recordingDelegate: self)
            } else {
                movieFileOutput.stopRecording()
            }
            
        }
    }
    
}


// MARK: - Implement AVCaptureFileOutputRecordingDelegate
extension ContentViewViewModel: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
       
        
        guard error == nil else {
            print("Video recording error \(error!.localizedDescription)")
            cleanTemporary(path: outputFileURL)
            return
        }
        
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            if status == .authorized {
                PHPhotoLibrary.shared().performChanges({
                    let options = PHAssetResourceCreationOptions()
                    options.shouldMoveFile = true
                    
                    let creationReq = PHAssetCreationRequest.forAsset()
                    creationReq.addResource(with: .video, fileURL: outputFileURL, options: options)
                    
                }) { success, error in
                    if success {
                        print("Movie saved successfully")
                    } else {
                        print("Failed to save movie \(error)")
                    }
                    self.cleanTemporary(path: outputFileURL)
                   
                }
            } else {
                print("User not authorized to save photo library")
                self.cleanTemporary(path: outputFileURL)
            }
        }
    }
    
    
    func cleanTemporary(path: URL) {
        if FileManager.default.fileExists(atPath: path.path()) {
            try? FileManager.default.removeItem(at: path)
        }
    }
    
}
