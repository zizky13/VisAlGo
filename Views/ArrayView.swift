//
//  SwiftUIView.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 01/08/25.
//

import SwiftUI

struct ArrayView: View {
    var array: [ArrayElement]
    var size: CGFloat
    
    var body: some View {
        let spacing: CGFloat = 10
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 10) {
                ForEach(0..<array.count, id: \.self) { index in
                    Text("\(index)")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.gray)
                        .frame(width: size)
                        .multilineTextAlignment(.center)
                }
            }
            
            
            HStack(spacing: spacing) {
                ForEach(array) { element in
                    ElementView(element: element, size: size)
                }
            }
        }
        
    }
}
