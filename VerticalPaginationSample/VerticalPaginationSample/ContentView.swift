//
//  ContentView.swift
//  VerticalPaginationSample
//
//  Created by Ahmed Mohiy on 27/02/2023.
//

import SwiftUI

var translation: CGFloat = 0
var currentPage = 0
var pageHeight: CGFloat = 0
var stackTopY: CGFloat = 0
var isDragging = false

struct ContentView: View {
    
    @State var colors: [Color] = [.pink, .red, .green]
    @State var location = CGPoint(x: 0, y: 0)
    
    
    var body: some View {
        
        VStack(spacing: 5) {
            ForEach(0..<3) { index in
                GeometryReader { innerProxy in
                    Rectangle()
                        .foregroundColor(colors[index])
                        .frame(width: innerProxy.frame(in: .global).size.width, height:innerProxy.frame(in: .global).size.height)
                        .coordinateSpace(name: "list_\(index)")
                        .task {
                            if index == colors.count-1 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    let height = innerProxy.frame(in: .local).height
                                    let remaining = abs(height - innerProxy.frame(in: .global).minY)
                                    let total = height * CGFloat(index-1) + remaining
                                    pageHeight = height
                                    stackTopY = total
                                    let stackX = innerProxy.frame(in: .local).width - innerProxy.frame(in: .global).maxX
                                    location = CGPoint(x: stackX, y: total)
                                }
                            }
                        }
                }
                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
            }
            
        }
        .position(location)
        .gesture(DragGesture()
            .onChanged({ value in
                guard  currentPage < colors.count - 1 else {return }
                if translation < value.translation.height  { return }
                
                isDragging = true
                translation = value.translation.height - translation
                location = CGPoint(x: location.x, y: location.y + translation)
                translation = value.translation.height
            })
                .onEnded({ _ in
                    guard isDragging else {return}
                    guard  currentPage < colors.count - 1 else {return }
                    
                    isDragging = false
                    currentPage += 1
                    translation = 0
                    let newY = stackTopY - (CGFloat(currentPage) * pageHeight)
                    withAnimation {
                        location = CGPoint(x: location.x, y: newY)
                    }
                    
                }))
    }
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
