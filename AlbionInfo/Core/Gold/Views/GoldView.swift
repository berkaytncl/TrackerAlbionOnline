//
//  GoldView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 12.06.2024.
//

import SwiftUI
import SwiftfulRouting
import SwiftfulUI

struct GoldView: View {
    let router: AnyRouter
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack {
                header
                
                ChartView()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
    }
    
    private var header: some View {
        HeaderView(
            title: LocalizedKey.goldPrice.localized,
            leftImageName: "arrow.uturn.left",
            leftBarItemPressed: dismissScreen
        )
    }
    
    func dismissScreen() {
        router.dismissScreen()
    }
}

#Preview {
    RouterView { router in
        GoldView(router: router)
    }
}
