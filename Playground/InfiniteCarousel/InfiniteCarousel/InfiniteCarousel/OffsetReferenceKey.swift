//
//  OffsetReferenceKey.swift
//  InfiniteCarousel
//
//  Created by Ahmed Mohiy on 28/03/2023.
//

import SwiftUI

struct OffsetReferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    func offsetX(_ isEnabled: Bool, completion: @escaping (CGRect) -> ()) -> some View {
        self.frame(maxWidth: .infinity)
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    if isEnabled {
                        Color.clear
                            .preference(key: OffsetReferenceKey.self, value: rect)
                            .onPreferenceChange(OffsetReferenceKey.self, perform: completion)
                    }
                }
            }
    }
}
