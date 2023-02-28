//
//  PlayerViewControllerRepresentable.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 22/02/2023.
//

import SwiftUI

struct PlayerView: UIViewRepresentable {
   
    
    let viewModel: PlayerViewViewModel
    
    
    func makeUIView(context: Context) -> PlayerViewUIKit {
        let view = PlayerViewUIKit()
        return view
    }
    
    func updateUIView(_ uiView: PlayerViewUIKit, context: Context) {
        uiView.viewModel = viewModel
    }
    
   
    
}
