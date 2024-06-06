//
//  KDInfoView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import SwiftUI
import SwiftfulRouting
import SwiftfulUI

struct KDInfoView: View {
    @StateObject private var viewModel: KDInfoViewModel
    @State private var didAppear: Bool = false
    
    init(router: AnyRouter) {
        _viewModel = StateObject(wrappedValue: KDInfoViewModel(router: router))
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.albionDarkBrown.ignoresSafeArea()
            
            if viewModel.kdReports.isEmpty {
                Text(.noKillDeathReport)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            VStack {
                header
                infoSection
                scrollViewSection
            }
            
            bottomAddNewPlayerSection
        }
        .onAppear {
            if didAppear {
                viewModel.updateSortAndFilterData()
                viewModel.refreshKDReportData()
            } else {
                didAppear.toggle()
            }
        }
        .refreshable {
            viewModel.refreshKDReportData()
        }
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
    }
    
    private var header: some View {
        HeaderView(
            title: LocalizedKey.playersInfo.localized,
            leftImageName: "arrow.uturn.left",
            rightImageName: "slider.horizontal.3",
            leftBarItemPressed: viewModel.dismissScreen,
            rightBarItemPressed: viewModel.goKDSettingsScreen
        )
    }
    
    private var infoSection: some View {
        VStack {
            Text(.reportsFound, with: viewModel.kdReports.count)
            
            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
        }
    }
    
    private var scrollViewSection: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(viewModel.kdReports, id: \.eventID) { kdReport in
                    KDReportCell( kdReport: kdReport)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .asButton(.press) {
                            viewModel.goKDDetailScreen(kdReport: kdReport)
                        }
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .padding(.bottom, 6)
                }
            }
            .padding(.top)
        }
    }
    
    private var bottomAddNewPlayerSection: some View {
        HStack {
            if viewModel.kdReports.isEmpty {
                Text(.addNewPlayer)
                Image(systemName: "arrow.right")
            }
            
            Circle()
                .fill(Color.albionBrown)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: "plus")
                        .bold()
                        .asButton(.press) {
                            viewModel.goKDTrackPlayerScreen()
                        }
                        .foregroundStyle(.albionDarkBrown)
                }
                .shadow(color: .albionDarkBrown, radius: 10)
        }
        .padding([.bottom, .trailing], 40)
    }
}

#Preview {
    RouterView { router in
        KDInfoView(router: router)
    }
}
