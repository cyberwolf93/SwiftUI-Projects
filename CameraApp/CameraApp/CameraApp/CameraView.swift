//
//  CameraView.swift
//  CameraApp
//
//  Created by Ahmed Mohiy on 14/03/2023.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewRepresentable {
    
    let session: AVCaptureSession
    
    
    func makeUIView(context: Context) -> CameraViewUIKit {
        let view = CameraViewUIKit()
        view.session = session
        return view
        
    }
    
    func updateUIView(_ uiView: CameraViewUIKit, context: Context) {
        
    }
    
    
}


