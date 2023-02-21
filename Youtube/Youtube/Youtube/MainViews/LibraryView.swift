//
//  LibraryView.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 21/02/2023.
//

import SwiftUI

struct LibraryView: View {
    
    private var historyVideoWidth: CGFloat = 180
    private var viewPadding: CGFloat = 12
    private var playlistRowImageWidth: CGFloat = 40
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Group {
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("library_history")
                        Spacer()
                        Button(action: {}) {
                            Text("library_view_all")
                        }
                    }
                    historyView
                        .padding(.vertical, 6)
                }
                .padding(.horizontal, viewPadding)
                Divider()
                    .padding(.top, 40)
                
                Group {
                    userContentView
                }
                .padding(.horizontal, viewPadding)
                .padding(.vertical, 20)
                
                Divider()
                
                Group {
                    playlistview
                }
                .padding(.horizontal, viewPadding)
                .padding(.vertical, 20)
                
            }
        }
    }
    
    // MARK: HistoryView
    var historyView: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .center, spacing: 18) {
                ForEach(0..<10) { index in
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2023/02/03/05/11/youtube-background-7764170__340.jpg")) { image in
                            image
                                .resizable()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: historyVideoWidth, height: historyVideoWidth * 9 / 16 )
                        .background(.gray)
                        .cornerRadius(12)
                        
                        HStack(alignment: .top) {
                            Text("I Drag Raced a BMW M5 E39 v Alpinas!")
                                .lineLimit(2)
                                .font(.title3)
                                .padding(0)
                            Spacer()
                            Image(systemName: "ellipsis")
                                .font(.body)
                                .transformEffect(.init(rotationAngle: CGFloat.pi/2))
                                .offset(x: 20)
                        }
                        
                        Text("Germany Cards")
                            .font(.caption2)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                    }
                    .frame(width: historyVideoWidth)
                }
            }
        }
        .scrollIndicators(.never)
    }
    
    //MARK: user content view
    var userContentView: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 18) {
                Image(systemName: "play.square")
                    .frame(width: 30)
                Text("library_your_videos")
                Spacer()
            }
            
            
            HStack(spacing: 18) {
                Image(systemName: "arrow.down.to.line")
                    .frame(width: 30)
                VStack (alignment: .leading){
                    Text("library_downloads")
                    Text("\(20) \("library_recommendations".localize)")
                        .font(Font.caption)
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
                Spacer()
            }
            
            HStack(spacing: 18) {
                Image(systemName: "film")
                    .frame(width: 30)
                Text("library_your_movies")
                Spacer()
            }
            
        }
        .font(Font.title3)
    }
    
    //MARK: Playlist view
    var playlistview: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack{
                Text("library_playlist")
                    .font(.title3)
                Spacer()
                Text("library_recently_added")
                    .font(.title3)
                Image(systemName: "chevron.down")
                    .font(.body)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Button(action: {}) {
                    HStack(spacing: 20){
                        Image(systemName: "plus")
                            .frame(width: playlistRowImageWidth)
                        Text("library_new_playlist")
                    }
                }
                
                HStack(spacing: 20){
                    Image(systemName: "clock")
                        .frame(width: playlistRowImageWidth)
                    VStack(alignment: .leading) {
                        Text("library_watch_later")
                        Text("\(2) \("library_unwatched_videos".localize)")
                            .font(.body)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                    }
                    
                }
                
                HStack(spacing: 20){
                    Image(systemName: "hand.thumbsup")
                        .frame(width: playlistRowImageWidth)
                    VStack(alignment: .leading) {
                        Text("library_liked_videos")
                        Text("\(4) \("library_videos".localize)")
                            .font(.body)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                    }
                    
                }
                
                HStack(spacing: 20){
                    AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQikvMfXSm_KGdWaPI9y-t-oXE_v5tYlmD2uw&usqp=CAU")) { image in
                        image
                            .resizable()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                            .foregroundColor(.red)
                    }
                    .frame(width: playlistRowImageWidth, height: playlistRowImageWidth)

                        
                    VStack(alignment: .leading) {
                        Text("Cars")
                        Text("\(4) \("library_videos".localize)")
                            .font(.body)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                    }
                    
                }
                
                HStack(spacing: 20){
                    AsyncImage(url: URL(string: "https://i.pinimg.com/originals/ba/d4/5a/bad45a40fa6e153ef8d1599ba875102c.png")) { image in
                        image
                            .resizable()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                            .foregroundColor(.red)
                    }
                    .frame(width: playlistRowImageWidth, height: playlistRowImageWidth)

                        
                    VStack(alignment: .leading) {
                        Text("Food")
                        Text("\(4) \("library_videos".localize)")
                            .font(.body)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                    }
                    
                }
            }
            .font(Font.title3)
        }
        
        
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
