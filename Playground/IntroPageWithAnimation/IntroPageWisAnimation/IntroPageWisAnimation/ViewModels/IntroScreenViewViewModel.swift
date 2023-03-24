//
//  IntroScreenViewViewModel.swift
//  IntroPageWisAnimation
//
//  Created by Ahmed Mohiy on 24/03/2023.
//

import Foundation
import Lottie

class IntroScreenViewViewModel {

    let pages: [Page]
    
    init() {
        self.pages = [
            .init(title: "Reuest Pickup",
                  desc: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time",
                 lottie: .init(name: "lottie_1", bundle: .main)),
            .init(title: "Track Delivery",
                  desc: "The best part starts when our courier is on the way to your location, as you will get real time notifications as to exact location of the courier",
                 lottie: .init(name: "lottie_2", bundle: .main)),
            .init(title: "Receive Package",
                  desc: "The journey ends when your package get to it's location, Get notified immediately your package is received at its intended location",
                 lottie: .init(name: "lottie_3", bundle: .main))
            
        ]
    }
    
    
}

