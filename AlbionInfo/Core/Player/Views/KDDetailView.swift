//
//  KDDetailView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 11.07.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct KDDetailView: View {
    @StateObject var viewModel: KDDetailViewModel
    
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
            title: .reportDetail,
            leftImageName: "arrow.down",
            leftBarItemPressed: viewModel.dismissScreen
        )
    }
    
    private var reportSection: some View {
        KDReportCell(kdReport: viewModel.kdReport)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.bottom, 6)
    }
    
    private var equipmentsSection: some View {
        VStack {
            Text(.equipments)
            
            KDEquipments(
                kdReport: viewModel.kdReport,
                itemPressed: viewModel.goToItemDetailScreen
            )
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
            Text(.inventoryTitle, with: viewModel.kdReport.victim.name)
            
            let loot = viewModel.kdReport.victim.loot.compactMap { $0 }
            
            if loot.isEmpty {
                Text(.inventoryEmpty)
                    .padding()
            } else {
                NonLazyVGrid(columns: 6, spacing: 0, items: loot) { item in
                    EquipmentCell(
                        equipmentData: item,
                        imagePressed: viewModel.goToItemDetailScreen
                    )
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
        KDDetailView(
            viewModel: KDDetailViewModel(
                router: router,
                kdReport: .mock,
                itemDataService: ItemsDataService.shared,
                languageManager: LanguageManager.shared
            )
        )
    }
}
