//
//  ContentViewViewModel.swift
//  CameraApp
//
//  Created by Ahmed Mohiy on 14/03/2023.
//

import Foundation
import AVFoundation

class ContentViewViewModel {
    
    let session: AVCaptureSession
    let queue = DispatchQueue(label: "AVCaptureSession queue")
    
    init() {
        self.session = AVCaptureSession()
        queue.async {
            self.configureSession()
        }
    }
    
    func configureSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo
        
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
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                
            } else {
                session.commitConfiguration()
                return
            }
            
            let audioDevice = AVCaptureDevice.default(for: .audio)
            let audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice!)
            
            if session.canAddInput(audioDeviceInput) {
                session.addInput(audioDeviceInput)
            } else {
                print("Could not add audio device input to the session")
            }
            
        } catch {
            session.commitConfiguration()
            return
        }
        
        
        session.commitConfiguration()
        
        
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            session.startRunning()
            
        case .notDetermined:
            queue.suspend()
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.session.startRunning()
                }
                self.queue.resume()
            }
            
        default:
            break
        }
        
        
        
    }
    
    
    
}
