//
//  Page.swift
//  IntroPageWisAnimation
//
//  Created by Ahmed Mohiy on 24/03/2023.
//

import Foundation
import Lottie

struct Page: Identifiable {
    let id: UUID = UUID()
    let title: String
    let desc: String
    let lottie: LottieAnimationView
    
}
