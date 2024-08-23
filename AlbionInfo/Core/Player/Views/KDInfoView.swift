//
//  KDInfoView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct KDInfoView: View {
    @StateObject var viewModel: KDInfoViewModel
    
    @State private var didAppear: Bool = false
    
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
            .padding(.bottom, 4)
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
        HStack {
            HeaderView(
                title: .playersInfo,
                isRootView: true
            )
            
            HStack {
                Image(systemName: "slider.horizontal.3")
                    .padding(8)
                    .background(.albionDarkBrown.opacity(0.001))
                    .onTapGesture {
                        viewModel.goKDSettingsScreen()
                    }
                
                Image(systemName: "plus")
                    .padding(8)
                    .background(.albionDarkBrown.opacity(0.001))
                    .onTapGesture {
                        viewModel.goKDTrackPlayerScreen()
                    }
            }
            .padding(8)
            .font(.title3)
        }
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
}

#Preview {
    RouterView { router in
        KDInfoView(
            viewModel: KDInfoViewModel(
                router: router,
                kdReportDataService: KDReportDataService(),
                favoritePlayerDataManager: FavoritePlayerDataManager.shared
            )
        )
    }
}
