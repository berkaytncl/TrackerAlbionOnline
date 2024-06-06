//
//  RootView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 6.06.2024.
//

import SwiftUI
import SwiftfulRouting
import SwiftfulUI

struct RootView: View {
    let router: AnyRouter
    
    var body: some View {
        ZStack {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack {
                titleSection
                navigationButtons
            }
        }
        .foregroundStyle(.albionBrown)
    }
    
    private var titleSection: some View {
        ZStack(alignment: .bottom) {
            Image(.albiononline)
                .resizable()
                .scaledToFit()
            
            Text("Albion Info")
                .font(.largeTitle)
                .fontWeight(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .padding(.bottom, 30)
    }
    
    private var navigationButtons: some View {
        Group {
            Text(.player)
                .asButton(.press) {
                    router.showScreen(.push) { router in
                        KDInfoView(router: router)
                    }
                }
            
            Text(.items)
                .asButton(.press) {
                    router.showScreen(.push) { router in
                        ItemsView(router: router)
                    }
                }
            
            Text(.gold)
                .asButton(.press) {
                    router.showScreen(.push) { router in
                        GoldView(router: router)
                    }
                }
            
            Text(.settings)
                .asButton(.press) {
                    router.showScreen(.push) { router in
                        SettingsView(router: router)
                    }
                }
        }
        .font(.title)
        .fontWeight(.heavy)
        .padding(4)
    }
}

#Preview {
    RouterView { router in
        RootView(router: router)
    }
}
