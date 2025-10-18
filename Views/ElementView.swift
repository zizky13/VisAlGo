//
//  File 2.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 01/08/25.
//

import SwiftUI

struct ElementView: View {
    var element: ArrayElement
    var size: CGFloat
    
    var body: some View {
        Text(element.value)
            .font(.system(size: size * 0.5))
            .bold()
            .frame(width: size, height: size)
            .background(element.color)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
