//
//  ButtonBackgroundCircle.swift
//  CameraApp
//
//  Created by Ahmed Mohiy on 14/03/2023.
//

import SwiftUI

struct ButtonBackgroundCircle: View {
    var body: some View {
        Circle()
            .strokeBorder(.thinMaterial, lineWidth: 0.3, antialiased: false)
            .foregroundColor(.clear)
            .background(Material.ultraThinMaterial)
            .containerShape(Circle())
            
    }
}

struct ButtonBackgroundCircle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBackgroundCircle()
            .previewLayout(.sizeThatFits)
            
    }
}
