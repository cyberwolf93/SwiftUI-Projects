//
//  LottieRepresentableView.swift
//  IntroPageWisAnimation
//
//  Created by Ahmed Mohiy on 24/03/2023.
//


import SwiftUI

struct LottieRepresentableView: UIViewRepresentable {
    
    @Binding var page: Page
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        makeLottieView(to: view)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeLottieView(to: UIView) {
        let lottieView = page.lottie
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        to.addSubview(lottieView)
        
        NSLayoutConstraint.activate([
            lottieView.topAnchor.constraint(equalTo: to.topAnchor),
            lottieView.bottomAnchor.constraint(equalTo: to.bottomAnchor),
            lottieView.leftAnchor.constraint(equalTo: to.leftAnchor),
            lottieView.rightAnchor.constraint(equalTo: to.rightAnchor),
        ])
    }
}
