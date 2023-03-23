//
//  ContentView.swift
//  CameraApp
//
//  Created by Ahmed Mohiy on 14/03/2023.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    let viewModel = ContentViewViewModel()
    @State var isRecording = false
    @State var photoLibraryPresented = false
    @State var selectedItems: [PhotosPickerItem] = []
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                CameraView(session: viewModel.session)
                    .ignoresSafeArea()
                
                HStack {
                    Button {
//                        photoLibraryPresented.toggle()
                    } label: {
                        PhotosPicker(selection: $selectedItems) {
                            Image(systemName: "photo.stack")
                                .padding(10)
                                .background(ButtonBackgroundCircle())
                        }
                    }
                    .disabled(isRecording)
                    .opacity(isRecording ? 0.1 : 1)
                    
                    
                    Spacer()
                    
                    Button {
                        isRecording.toggle()
                        viewModel.startRecording()
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
                        viewModel.changeCamera()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .padding(10)
                            .background(ButtonBackgroundCircle())
                        
                    }
                    .disabled(isRecording)
                    .opacity(isRecording ? 0.1 : 1)

                }
                .frame(maxHeight: 100)
                .padding(.horizontal, proxy.frame(in: .global).maxX * 0.1)
                .foregroundColor(.white)
                .font(.system(size: 30))
            }
        }
        .preferredColorScheme(.light)
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
