//
//  PlaceholderView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 13.07.2024.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.gray)
            .frame(width: 50, height: 50)
            .overlay {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .albionBrown))
                    .foregroundStyle(.albionWhite)
                    .scaleEffect(1.5)
                    .padding(.bottom, 8)
            }
    }
}

#Preview {
    PlaceholderView()
}
