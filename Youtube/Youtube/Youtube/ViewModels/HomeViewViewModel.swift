//
//  HoveViewViewModel.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 22/02/2023.
//

import Foundation
import Combine

struct ItemScrollProxy: Equatable {
    
    let viewModel: PlayerViewViewModel
    var rect: CGRect
    
    static func == (lhs: ItemScrollProxy, rhs: ItemScrollProxy) -> Bool {
        lhs.viewModel.id == rhs.viewModel.id
    }
    
}


class HomeViewViewModel: ObservableObject {
    
    @Published var cellsViewModels: [PlayerViewViewModel] = []
    @Published var updateCurrentVideoTime: String = ""
    
    var cellItemHeight: CGFloat = 0
    var currentVisibleViewModel: PlayerViewViewModel?
    var playerTimer: Timer?
    private var currentVisibleIndex = 0
    private var cancelable = Set<AnyCancellable>()
    
    func loadContent() {
        let viewModel1 = PlayerViewViewModel(videoInfo: example1)
        let viewModel2 = PlayerViewViewModel(videoInfo: example2)
        let viewModel3 = PlayerViewViewModel(videoInfo: example3)
        let viewModel4 = PlayerViewViewModel(videoInfo: example4)
        let viewModel5 = PlayerViewViewModel(videoInfo: example5)
        
        var viewModels = [viewModel1, viewModel2, viewModel3, viewModel4, viewModel5]
        viewModels.shuffle()
        
        cellsViewModels = viewModels
    }
    
    func stopAutoPlay() {
        currentVisibleViewModel?.player?.pause()
        playerTimer?.invalidate()
        playerTimer = nil
        currentVisibleViewModel = nil
    }
    
    func startAutoPlay(forPosition value: CGFloat) {
        stopAutoPlay()
        
        if cellItemHeight > 0 {
            currentVisibleIndex = Int(abs(value) / cellItemHeight) + 1
            currentVisibleIndex = currentVisibleIndex < cellsViewModels.count ? currentVisibleIndex : cellsViewModels.count - 1
            currentVisibleViewModel = cellsViewModels[currentVisibleIndex]
            currentVisibleViewModel?.remainingTimeSubject.sink(receiveValue: updateCurrentPlayingVideoElapsedTime).store(in: &cancelable)
            
            playerTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
                self?.currentVisibleViewModel?.player?.play()
            })
        }
    }
    
    func updateCurrentPlayingVideoElapsedTime(_ value: Double) {
        let mins = String(format: "%02d", Int(value / 60))
        let seconds = String(format: "%02d", Int(Int(value) % 60))
        updateCurrentVideoTime = "\(mins):\(seconds)"
    }
    
    func getPlayerDurationFor(viewModel: PlayerViewViewModel) -> String {
        guard let duration = viewModel.player?.currentItem?.duration.seconds, !duration.isNaN else {return "00:00"}
        let mins = String(format: "%02d", Int(duration / 60))
        let seconds = String(format: "%02d", Int(Int(duration) % 60))
        return "\(mins):\(seconds)"
    }
    
    
    
    func getTimeElapsedViewText(for viewModel: PlayerViewViewModel) -> String {
        var text = getPlayerDurationFor(viewModel: viewModel)
        if let currentPlayingVideo = currentVisibleViewModel, currentPlayingVideo.id == viewModel.id {
            text = updateCurrentVideoTime
        }
        
        return text
    }
    
    func numberOfViews(number: Int) -> String {
        if number > 999_999 {
            return "\(Int(number / 1_000_000))M"
        }
        
        if number > 999 {
            return "\(Int(number / 1000))K"
        }
        return "\(number)"
    }
    
    private var example1 = VideoItem(title: "Fastest cars in the world",
                                     pathName: "video-1",
                                     pathNameExtension: "mp4",
                                     thumbnail: "image-1",
                                     thumbnailExtension: "png",
                                     channelName: "Cars Channel",
                                     icon: "icon-3",
                                     iconExtension: "png",
                                     numberOfView: 10_000,
                                     date: Date(timeIntervalSinceNow: -21898912))
    
    private var example2 = VideoItem(title: "Fastest cars in the world",
                                     pathName: "video-2",
                                     pathNameExtension: "mp4",
                                     thumbnail: "image-2",
                                     thumbnailExtension: "jpg",
                                     channelName: "Cars show Channel",
                                     icon: "icon-2",
                                     iconExtension: "jpeg",
                                     numberOfView: 10_000_000,
                                     date: Date(timeIntervalSinceNow: -21898912763))
    
    
    private var example3 = VideoItem(title: "Fastest cars in the world",
                                     pathName: "video-2",
                                     pathNameExtension: "mp4",
                                     thumbnail: "image-3",
                                     thumbnailExtension: "jpeg",
                                     channelName: "Cars Channel",
                                     icon: "icon-3",
                                     iconExtension: "png",
                                     numberOfView: 10_000,
                                     date: Date(timeIntervalSinceNow: -78272832))
    
    
    private var example4 = VideoItem(title: "Fastest cars in the world",
                                     pathName: "video-4",
                                     pathNameExtension: "mp4",
                                     thumbnail: "image-4",
                                     thumbnailExtension: "jpeg",
                                     channelName: "Fast Cars Channel",
                                     icon: "icon-4",
                                     iconExtension: "png",
                                     numberOfView: 1_000,
                                     date: Date(timeIntervalSinceNow: -9182191919))
    
    private var example5 = VideoItem(title: "Fastest cars in the world",
                                     pathName: "video-5",
                                     pathNameExtension: "mp4",
                                     thumbnail: "image-5",
                                     thumbnailExtension: "jpeg",
                                     channelName: "Cars Channel",
                                     icon: "icon-4",
                                     iconExtension: "png",
                                     numberOfView: 47_000,
                                     date: Date(timeIntervalSinceNow: -901091390))
    
    
    static var example = VideoItem(title: "Fastest cars in the world",
                                     pathName: "video-1",
                                     pathNameExtension: "mp4",
                                     thumbnail: "image-1",
                                     thumbnailExtension: "png",
                                     channelName: "Cars Channel",
                                     icon: "icon-3",
                                     iconExtension: "png",
                                     numberOfView: 10_000,
                                     date: Date(timeIntervalSinceNow: -21898912))
    
    
}
