//
//  ContentView.swift
//  CustomTabbar
//
//  Created by Ahmed Mohiy on 26/03/2023.
//

import SwiftUI

enum TabbarItem :Int {
    case home = 0
    case gifts = 1
    case notifications = 2
    case chat = 3
}

struct Item: Hashable {
    let type: TabbarItem
    let imageName: String
}

struct ContentView: View {
    
    @State var selecteditem: TabbarItem = .home
    @State var tabBarSize: CGSize = .zero
    @Namespace var animation
    var tabItems: [Item] = [.init(type: .home, imageName: "house.fill"),
                            .init(type: .gifts, imageName: "gift.fill"),
                            .init(type: .notifications, imageName: "bell.fill"),
                            .init(type: .chat, imageName: "message.circle.fill")]
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            tabView()
            customTabView()
        }
        
    }
    
    @ViewBuilder
    func tabView() -> some View {
        TabView(selection: $selecteditem) {
            Color(.red)
                .tag(TabbarItem.home)
                .ignoresSafeArea()
            
            Color(.purple)
                .tag(TabbarItem.gifts)
                .ignoresSafeArea()
            
            Color(.black)
                .tag(TabbarItem.notifications)
                .ignoresSafeArea()
            
            Color(.blue)
                .tag(TabbarItem.chat)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func customTabView() -> some View{
        HStack(alignment: .center, spacing: 0) {
            
            ForEach(tabItems, id: \.self) { item in
                Button {
                    withAnimation(.spring()) {
                        selecteditem = item.type
                    }
                } label: {
                    Image(systemName: item.imageName)
                        .foregroundColor(selecteditem == item.type ? .red : .gray)
                        .padding(8)
                        .background(.white)
                        .clipShape(Circle())
                        .matchedGeometryEffect(id: item, in: animation)
                    
                }
                .frame(width: (UIScreen.main.bounds.width - 20) / 4 )
                .offset(y: selecteditem == item.type ? -30: 0)
            }
 
        }
        .font(.title)
        .frame(maxWidth: .infinity, maxHeight: 30)
        .padding(.vertical, 12)

        .background(Color.white.clipShape(TabbarCustomShap(itemIndex: CGFloat(selecteditem.rawValue))).cornerRadius(12))
        .padding(.horizontal, 12)
        .padding(.bottom, 10)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
