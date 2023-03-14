//
//  CamraViewUIKit.swift
//  CameraApp
//
//  Created by Ahmed Mohiy on 14/03/2023.
//

import UIKit
import AVFoundation

class CameraViewUIKit: UIView {
    
    var session: AVCaptureSession? {
        didSet {
            if let layer = self.layer as? AVCaptureVideoPreviewLayer {
                layer.session = session
                layer.videoGravity = .resizeAspectFill
            }
        }
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
