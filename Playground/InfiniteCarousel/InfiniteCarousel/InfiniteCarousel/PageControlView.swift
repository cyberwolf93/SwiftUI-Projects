//
//  PageControlView.swift
//  InfiniteCarousel
//
//  Created by Ahmed Mohiy on 28/03/2023.
//

import SwiftUI

struct PageControlView: UIViewRepresentable {
    
    var numberOfPages: Int
    var selectedPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = selectedPage
        pageControl.backgroundStyle = .prominent
        
        return pageControl
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = selectedPage
    }
    
    
}


