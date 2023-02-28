//
//  HomeView.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 21/02/2023.
//

import SwiftUI
struct HomeView: View {
    @ObservedObject var viewModel: HomeViewViewModel
    @State var index: Int = 0
    
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.cellsViewModels) { item in
                        VStack(alignment: .leading) {
                            
                            PlayerView(viewModel: item)
                                .frame(width: proxy.size.width, height: proxy.size.width * 9 / 16)
                                .overlay(alignment: .topLeading) {
                                    if viewModel.currentVisibleViewModel?.id == item.id {
                                        videoOverlay(viewModel: item)
                                    }
                                    
                                }
                            HStack(alignment: .top, spacing: 12){
                                Image(uiImage: UIImage.load(name: item.videoInfo.icon, with: item.videoInfo.iconExtension))
                                    .resizable()
                                    .frame(width: 44, height: 44, alignment: .center)
                                    .clipShape(Circle())
                                VStack(alignment: .leading){
                                    Text(item.videoInfo.title)
                                        .font(.body)
                                    Text(descriptionText(viewModel: item))
                                        .font(.caption)
                                        .foregroundColor(Color(uiColor: .secondaryLabel))
                                }
                                .lineLimit(2)
                                Spacer()
                            }
                            
                        }
                        .coordinateSpace(name: item.id.uuidString)
                        .padding(.vertical, 8)
                        .background {
                            GeometryReader { scrollProxy in
                                Color.clear
                                    .preference(key: CellDynamicHeightPrefrenceKey.self, value: scrollProxy.size.height)
                            }
                        }
                        
                    }
                }
                .background {
                    GeometryReader { scrollProxy in
                        Color.clear
                            .preference(key: ScrollViewMinYPrefrenceKey.self, value: scrollProxy.frame(in: .named("scroll")).minY)
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .onAppear( perform: { viewModel.loadContent() })
            .onPreferenceChange(ScrollViewMinYPrefrenceKey.self) { value in
                viewModel.startAutoPlay(forPosition: value)
            }
            
            .onPreferenceChange(CellDynamicHeightPrefrenceKey.self) { value in
                viewModel.cellItemHeight = value
            }
            
        }
        
    }
    
    func videoOverlay(viewModel: PlayerViewViewModel) ->  some View {
        return Rectangle()
            .foregroundColor(Color(white: 0, opacity: 0))
            .overlay(alignment: .topTrailing) {
                volumnAndClosedCaptionView
            }
            .overlay(alignment: .bottomTrailing) {
                timeElapsedView(itemViewModel: viewModel)
            }
        
    }
    
    var volumnAndClosedCaptionView: some View {
        return HStack {
            Spacer()
            
            VStack {
                HStack(spacing: 8) {
                    Image(systemName: "speaker.slash.fill")
                    Image(systemName: "line.diagonal")
                        .rotationEffect(.degrees(-45))
                        .opacity(0.5)
                    Image(systemName: "repeat.1.circle.fill")
                }
                .font(.title2)
                .foregroundColor(.white)
                .padding(12)
                .background(Color(white: 0, opacity: 0.5))
                .cornerRadius(8)
                .padding(12)
                    
                Spacer()
            }
            .fixedSize()
        }
    }
    
    
    
    func timeElapsedView(itemViewModel: PlayerViewViewModel)  -> some View {
        return HStack {
            Spacer()
                
            VStack {
                Spacer()
                
                Text("\(viewModel.getTimeElapsedViewText(for: itemViewModel))")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color(white: 0, opacity: 0.6))
                    .cornerRadius(4)
                    .padding(12)
                
            }
            .fixedSize()
        }
        
    }
    
    func descriptionText(viewModel: PlayerViewViewModel) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        let date = dateFormatter.string(from: viewModel.videoInfo.date)
        return "\(viewModel.videoInfo.channelName) ・ \(self.viewModel.numberOfViews(number: viewModel.videoInfo.numberOfView)) \("Views") ・ \(date)"
    }
    
}



struct ScrollViewMinYPrefrenceKey: PreferenceKey {
    
    typealias Value = CGFloat
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
    
}

struct CellDynamicHeightPrefrenceKey: PreferenceKey{
    typealias Value = CGFloat
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewViewModel())
    }
}
