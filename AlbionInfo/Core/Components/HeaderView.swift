//
//  HeaderView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 15.07.2024.
//

import SwiftUI

struct HeaderView: View {
    var title: LocalizedKey
    var isRootView: Bool = false
    var leftImageName: String = "arrow.backward"
    var leftBarItemPressed: VoidAction = nil
    
    var body: some View {
        HStack {
            Image(systemName: leftImageName)
                .padding(8)
                .background(.albionDarkBrown.opacity(0.001))
                .opacity(isRootView ? 0 : 1)
                .onTapGesture {
                    leftBarItemPressed?()
                }
            
            Text(title)
                .font(.title)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(8)
        .font(.title3)
    }
}

#Preview {
    HeaderView(title: .player)
}
