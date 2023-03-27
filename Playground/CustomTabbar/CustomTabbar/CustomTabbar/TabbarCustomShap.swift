//
//  TabbarCustomShap.swift
//  CustomTabbar
//
//  Created by Ahmed Mohiy on 26/03/2023.
//

import SwiftUI

struct TabbarCustomShap: Shape {
    
    var itemIndex: CGFloat
    
    
    
    var animatableData: CGFloat {
        get { itemIndex }
        set { itemIndex = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let itemWidth = (rect.width / 4)
            let curveDepth: CGFloat = rect.height * 0.5
            let startPosition: CGFloat = itemIndex * itemWidth
            let bottomPoint = CGPoint(x:  startPosition + itemWidth / 2, y: curveDepth)
            let control1 = CGPoint(x: startPosition + (itemWidth * 0.25), y: 0)
            let control2 = CGPoint(x: startPosition + (itemWidth * 0.25), y: curveDepth)
            
            path.move(to: CGPoint(x: startPosition, y: 0))
            path.addCurve(to: bottomPoint,
                          control1: control1,
                          control2: control2)
            
            
            let control3 = CGPoint(x: startPosition + (itemWidth * 0.75) , y: curveDepth )
            let control4 = CGPoint(x: startPosition + (itemWidth * 0.75), y: 0)
            
            
            let endPoint = CGPoint(x: startPosition + itemWidth, y: 0)
            path.addCurve(to: endPoint,
                          control1: control3,
                          control2: control4)
        }
    }
}


