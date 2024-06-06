//
//  HeaderView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 15.07.2024.
//

import SwiftUI
import SwiftfulUI

struct HeaderView: View {
    var title: String = "Players Info"
    var leftImageName: String = "arrow.uturn.left"
    var rightImageName: String?
    var leftBarItemPressed: VoidAction = nil
    var rightBarItemPressed: VoidAction = nil
    
    var body: some View {
        HStack {
            Image(systemName: leftImageName)
                .padding(8)
                .background(.albionDarkBrown.opacity(0.001))
                .asButton(.press) {
                    leftBarItemPressed?()
                }
            
            Text(title)
                .font(.title2)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let rightImageName {
                Image(systemName: rightImageName)
                    .padding(8)
                    .background(.albionDarkBrown.opacity(0.001))
                    .asButton(.press) {
                        rightBarItemPressed?()
                    }
            }
        }
        .font(.title3)
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}

#Preview {
    HeaderView()
}
