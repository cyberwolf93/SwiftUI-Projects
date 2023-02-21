//
//  UploadView.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 21/02/2023.
//

import SwiftUI

struct UploadView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            Text("upload View")
            Button {
                dismiss()
            } label: {
                Text("close")
            }

        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
