//
//  ContentView.swift
//  DropDownMenu
//
//  Created by Ahmed Mohiy on 23/03/2023.
//

import SwiftUI

struct ContentView: View {
    let values: [String] = ["Easy", "Normal", "Hard", "Expert"]
    @State var currentValue = "Easy"
    var body: some View {
        VStack {
            DropDownView(values: values,type: .down, currentValue: $currentValue )
                .frame(width: 130, height: 55)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
