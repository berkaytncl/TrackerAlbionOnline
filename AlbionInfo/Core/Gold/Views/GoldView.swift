//
//  GoldView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 12.06.2024.
//

import SwiftUI

struct GoldView: View {
    var body: some View {
        ZStack {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack {
                HeaderView(
                    title: .goldPrice,
                    isRootView: true
                )

                ChartView()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
    }
}

#Preview {
    GoldView()
}
