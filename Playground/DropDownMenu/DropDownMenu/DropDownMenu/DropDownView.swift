//
//  DropDownView.swift
//  DropDownMenu
//
//  Created by Ahmed Mohiy on 23/03/2023.
//

import SwiftUI

struct DropDownView: View {
    
    let values: [String]
    let type: DropDownType
    @Binding var currentValue: String
    
    var selectedTintColor: Color = .primary.opacity(0.1)
    var tintColor: Color = .white.opacity(0.05)
    
    @State var isExpanded = false
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    if type == .down {
                        downLoopViews(size: size)
                    } else {
                        movigLoopViews(size: size)
                    }
                }
                .background(
                    Rectangle()
                        .fill(tintColor)
                )
                .offset(y: getViewOffset(size: size))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .mask(alignment: .top) {
                Rectangle()
                    .frame(height: isExpanded ? size.height * CGFloat(values.count) : size.height)
                    .offset(y: getViewOffsetForMask(size: size))
            }
           
        }
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.up.chevron.down")
                .padding(.trailing, 8)
        }
        
    }
    
    @ViewBuilder
    func row(value: String, size: CGSize) -> some View {
        Text(value)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.7)) {
                    if isExpanded {
                        currentValue = value
                        isExpanded = false
                    } else {
                        isExpanded = currentValue == value ? true : false
                    }
                }
                
            }
            .background{
                if currentValue == value {
                    Rectangle()
                        .fill(selectedTintColor)
                        .transition(.identity)
                }
            }
            
            
    }
    
    @ViewBuilder
    func downLoopViews(size: CGSize) -> some View {
        row(value: currentValue, size: size)
        ForEach(values, id: \.self) { value in
            if value != currentValue {
                row(value: value, size: size)
            }
        }
    }
    
    
    @ViewBuilder
    func movigLoopViews(size: CGSize) -> some View {
        ForEach(values, id: \.self) { value in
            row(value: value, size: size)
        }
    }
    
    func getViewOffset(size: CGSize) -> CGFloat {
        if type == .moving {
            return CGFloat(values.firstIndex(of: currentValue) ?? 0)  * -size.height
        }
        
        return 0
    }
    
    func getViewOffsetForMask(size: CGSize) -> CGFloat {
        if isExpanded  {
            return getViewOffset(size: size)
        }
        
        return 0
    }
    
    
    enum DropDownType {
        case moving
        case down
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView(values: ["Easy", "Normal", "Hard", "Expert"],type: .moving, currentValue: Binding<String>(get: {
            "Easy"
        }, set: { str in
            
        }))
    }
}
