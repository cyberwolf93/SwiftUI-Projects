//
//  PlayerViewController.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 22/02/2023.
//

import UIKit
import AVFoundation

class PlayerViewUIKit: UIView {
    
    private var playerLayerInitialized = false
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var viewModel: PlayerViewViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initPlayer()
    }
    
    func initPlayer() {
        guard let viewModel else {return}
        guard !playerLayerInitialized else {return}
        playerLayerInitialized = true
        self.player = viewModel.player
        playerLayer = AVPlayerLayer(player: self.player)
        playerLayer?.frame = self.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        print(self.frame)
        playerLayer?.backgroundColor = UIColor.green.cgColor
        self.layer.addSublayer(playerLayer!)
        
    }
    
    
}
