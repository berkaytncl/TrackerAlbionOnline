//
//  KDDetailView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 11.07.2024.
//

import SwiftUI
import SwiftfulRouting
import SwiftfulUI

struct KDDetailView: View {
    private let kdReport: KDReportResponse
    private let router: AnyRouter
    
    init(router: AnyRouter, kdReport: KDReportResponse) {
        self.router = router
        self.kdReport = kdReport
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack {
                header
                ScrollView(.vertical, showsIndicators: false) {
                    reportSection
                    equipmentsSection
                    inventorySection
                        .padding(.bottom)
                }
                .foregroundStyle(.albionDarkBrown)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
    }
    
    private var header: some View {
        HeaderView(
            title: LocalizedKey.reportDetail.localized,
            leftImageName: "arrow.uturn.down",
            leftBarItemPressed: router.dismissScreen
        )
    }
    
    private var reportSection: some View {
        KDReportCell(kdReport: kdReport)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.bottom, 6)
    }
    
    private var equipmentsSection: some View {
        VStack {
            Text(.equipments)
            
            KDEquipments(kdReport: kdReport)
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .padding(.horizontal, 4)
        .background(.albionBrown)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.bottom, 6)
    }
    
    private var inventorySection: some View {
        VStack {
            Text(.inventoryTitle, with: kdReport.victim.name)
            
            let loot = kdReport.victim.loot.compactMap { $0 }
            
            if loot.isEmpty {
                Text(.inventoryEmpty)
                    .padding()
            } else {
                NonLazyVGrid(columns: 6, spacing: 0, items: loot) { item in
                    EquipmentCell(equipmentData: item)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .padding(.horizontal, 4)
        .background(.albionBrown)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.bottom, 6)
    }
}

#Preview {
    RouterView { router in
        KDDetailView(router: router, kdReport: .mock)
    }
}
