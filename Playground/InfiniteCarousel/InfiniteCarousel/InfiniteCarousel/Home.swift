//
//  Home.swift
//  InfiniteCarousel
//
//  Created by Ahmed Mohiy on 28/03/2023.
//

import SwiftUI

struct Page: Identifiable, Hashable {
    var id: UUID = UUID()
    var color: Color
}

struct Home: View {
    
    @State var pages: [Page] = [.init(color: .white), .init(color: .brown), .init(color: .blue), .init(color: .yellow), .init(color: .red)]
    @State var selectedPage: UUID = UUID()
    @State var fakePages: [Page] = [.init(color: .white), .init(color: .brown), .init(color: .blue), .init(color: .yellow), .init(color: .red)]
    
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            TabView(selection: $selectedPage) {
                ForEach(fakePages, id: \.id) { page in
                    Rectangle()
                        .fill(page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .cornerRadius(12)
                        .offsetX(page.id == selectedPage, completion: { rect in
                            let pageOffset = rect.minX - (size.width * CGFloat(getFakeIndex(id: page.id)))
                            let progress = pageOffset / size.width
                            
                            if -progress < 1, let last = fakePages.last{
                                selectedPage = last.id
                            }
                            
                            if -progress > CGFloat(fakePages.count - 1), fakePages.count > 1 {
                                selectedPage = fakePages[1].id
                            }
                        })
                        .tag(page.id)
                }
            }
            .onAppear {
                fakePages = pages
                guard var first = pages.first, var last = pages.last else {return}
                first.id = UUID()
                last.id = UUID()
                fakePages.insert(last, at: 0)
                fakePages.append(first)
                if fakePages.count > 1 {
                    selectedPage = fakePages[1].id
                }
                

            }
            .overlay(alignment: .bottom, content: {
                PageControlView(numberOfPages: pages.count, selectedPage: getIndex(id: selectedPage))
                    .offset(y: -12)
            })
            .preferredColorScheme(.dark)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .frame(height: 400)
    }
    
    func getIndex(id: UUID) -> Int {
        return pages.firstIndex(where: {$0.id == id}) ?? 0
    }
    
    func getFakeIndex(id: UUID) -> Int {
        return fakePages.firstIndex(where: {$0.id == id}) ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
