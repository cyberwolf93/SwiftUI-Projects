//
//  ContentView.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 21/02/2023.
//

import SwiftUI

enum PageType {
    case home
    case shorts
    case upload
    case subscriptions
    case library
}

struct TabbarItem: Identifiable {
    var id = UUID()
    var title: LocalizedStringKey
    var type: PageType
    var imageName: String
}

struct MainView: View {
    @State private var  pageType: PageType = .home
    @State var isUploadViewPresented = false
    private var tabbarItems: [TabbarItem] = []
    
    init() {
        let home = TabbarItem(title: "tapbar_home", type: .home, imageName: "house")
        let shorts = TabbarItem(title: "tapbar_shorts", type: .shorts, imageName: "film.stack")
        let upload = TabbarItem(title: "", type: .upload, imageName: "plus.circle")
        let subscriptions = TabbarItem(title: "tapbar_subscriptions", type: .subscriptions, imageName: "lock.rectangle.stack")
        let library = TabbarItem(title: "tapbar_library", type: .library, imageName: "person.crop.rectangle.stack")
        
        tabbarItems = [home, shorts, upload, subscriptions, library]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                currentPage
            }
            Divider()
            HStack(alignment: .center) {
                ForEach(tabbarItems) { item in
                    Spacer()
                    Button(action: {
                        if item.type == .upload {
                            isUploadViewPresented = true
                            return
                        }
                        pageType = item.type
                    }) {
                        VStack(alignment: .center, spacing: 0) {
                            
                            if item.type != .upload {
                                Spacer()
                                Image(systemName: item.imageName)
                                    .symbolVariant(pageType == item.type ? .fill : .none)
                                    .font(.title3)
                                    .fontWeight(.light)
                                Spacer()
                                Text(item.title)
                                    .font(.system(size: 8, weight: .light))
                                Spacer()
                            } else {
                                Image(systemName: item.imageName)
                                    .font(.system(size: 44, weight: .light))
                            }
                            
                        }
                        .padding(.horizontal, 0)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 5)
            .frame(height: 54)
            .lineLimit(1)
            .background(Color(uiColor: .systemBackground))
            .foregroundColor(Color(uiColor: .label))
            .fullScreenCover(isPresented: $isUploadViewPresented) {
                UploadView()
            }
            
        }
    }
    
    // MARK: - Helper views
    @ViewBuilder var currentPage: some View {
        switch (pageType) {
        case .home:
            HomeView()
        case .shorts:
            ShortsView()
        case .upload:
            ScrollView{
                EmptyView()
            }
        case .subscriptions:
            SubscriptionsView()
        case .library:
            LibraryView()
        }
    }
    
    //MARK: - Actions
    func changeCurrentPage() {
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
