//
//  PlayerViewViewModel.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 22/02/2023.
//

import Foundation
import AVFoundation
import Combine

class PlayerViewViewModel: Identifiable {
    let id = UUID()
    var player: AVPlayer?
    let videoInfo: VideoItem
    
    var remainingTimeSubject =  PassthroughSubject<Double, Never>()
    
    init(videoInfo: VideoItem) {
        self.videoInfo = videoInfo
        
        if let url = Bundle.main.url(forResource: videoInfo.pathName, withExtension: videoInfo.pathNameExtension) {
            player = AVPlayer(url: url)
        }
        
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main, using: { [weak self] time in
            guard let duration = self?.player?.currentItem?.duration else {return}
            self?.remainingTimeSubject.send(duration.seconds - time.seconds)
        })
        
    }
    
}
