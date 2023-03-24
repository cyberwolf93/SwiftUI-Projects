//
//  IntroScreenView.swift
//  IntroPageWisAnimation
//
//  Created by Ahmed Mohiy on 24/03/2023.
//

import SwiftUI

struct IntroScreenView: View {
    var viewModel = IntroScreenViewViewModel()
    @State var pages: [Page] = []
    @State var currentIndex = 0
    @State var buttonPadding: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            HStack(spacing: 0) {
                ForEach($pages) { $page in
                    pageView(page: $page, size: size)
                }
            }
            .frame(width: size.width * CGFloat(pages.count), alignment: .leading)
            .onAppear {
                pages = viewModel.pages
                buttonPadding = (size.width / 2) * 0.35
            }
        }
        
    }
    
    @ViewBuilder
    func pageView(page: Binding<Page>, size: CGSize) -> some View {
        VStack {
            navigationBar()
            movableContent(page: page, size: size)
            Spacer(minLength: 0)
            buttonView(size: size)
        }
        .padding(14)
        .frame(width: size.width, height: size.height)
    }
    
    @ViewBuilder
    func movableContent(page: Binding<Page>, size: CGSize) -> some View {
        VStack(spacing: 14) {
            LottieRepresentableView(page: page)
                .frame(height: size.height * 0.5)
                .onAppear {
                    pages[currentIndex].lottie.play()
                }
                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                
            Text(page.wrappedValue.title)
                .font(.title.bold())
                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
            Text(page.wrappedValue.desc)
                .font(Font.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
            
        }
        .offset(x: -size.width * CGFloat(currentIndex))
        .onChange(of: currentIndex) { [currentIndex] newValue in
            buttonPadding = newValue == pages.count - 1 ? (size.width / 2) * 0.05 : (size.width / 2) * 0.35
            
            // reset previous
            pages[currentIndex].lottie.pause()
            pages[currentIndex].lottie.currentProgress = 0
            
            // update new
            pages[newValue].lottie.play()
        }
    }
    
    @ViewBuilder
    func navigationBar() -> some View {
        HStack {
            Button("Back") {
                if currentIndex > 0 {
                    currentIndex -= 1
                }
            }
            .opacity(currentIndex > 0 ? 1 : 0)
            Spacer(minLength: 0)
            Button("Skip") {
                currentIndex = pages.count - 1
            }
            .opacity(currentIndex < pages.count - 1 ? 1 : 0)
        }
        .animation(.easeInOut, value: currentIndex)
        .tint(Color("Green"))
        .fontWeight(.bold)
    }
    
    @ViewBuilder
    func buttonView(size: CGSize) -> some View {
        VStack(spacing: 12) {
            Text(currentIndex == pages.count - 1 ? "Login" : "Next")
                .font(.body.bold())
                .foregroundColor(.white)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background {
                    Capsule()
                        .fill(Color("Green"))
                }
                .padding(.horizontal, buttonPadding)
                .animation(.easeInOut(duration: 0.2), value: buttonPadding)
                .onTapGesture {
                    if currentIndex < pages.count - 1 {
                        currentIndex += 1
                    }
                }
            
            HStack {
                Text("Terms of Service")
                Text("Privacy Policy")
            }
            .font(.caption)
            .underline(true)
            
        }
    }
}

struct IntroScreenView_Previews: PreviewProvider {
    static var previews: some View {
        IntroScreenView()
    }
}
