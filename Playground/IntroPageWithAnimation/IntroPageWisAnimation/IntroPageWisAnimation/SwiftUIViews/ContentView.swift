//
//  ContentView.swift
//  IntroPageWisAnimation
//
//  Created by Ahmed Mohiy on 24/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        IntroScreenView()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
