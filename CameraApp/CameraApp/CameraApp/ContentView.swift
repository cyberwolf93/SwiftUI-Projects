//
//  ContentView.swift
//  CameraApp
//
//  Created by Ahmed Mohiy on 14/03/2023.
//

import SwiftUI

struct ContentView: View {
    let viewModel = ContentViewViewModel()
    @State var isRecording = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                CameraView(session: viewModel.session)
                    .ignoresSafeArea()
                
                HStack {
                    Button {
                        // TODO:
                    } label: {
                        Image(systemName: "photo.stack")
                            .padding(10)
                            .background(ButtonBackgroundCircle())
                    }
                    
                    Spacer()
                    
                    Button {
                        isRecording.toggle()
                    } label: {
                        Circle()
                            .strokeBorder(.white, lineWidth: 6, antialiased: true)
                            .foregroundColor(.clear)
                            .overlay(alignment: .center, content: {
                                if isRecording {
                                    Rectangle().foregroundColor(.red)
                                        .padding(8)
                                        .frame(width: 50, height: 50)
                                } else {
                                    Circle().foregroundColor(.white)
                                        .padding(12)
                                }
                            })
                            .containerShape(Circle())
                            .padding(10)
                    }
                    
                    Spacer()
                    
                    Button {
                        // TODO:
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .padding(10)
                            .background(ButtonBackgroundCircle())
                        
                    }

                }
                .frame(maxHeight: 100)
                .padding(.horizontal, proxy.frame(in: .global).maxX * 0.1)
                .foregroundColor(.white)
                .font(.system(size: 30))
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
