//
//  ChartView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 17.07.2024.
//

import SwiftUI

struct ChartView: View {
    @StateObject private var viewModel: ChartViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: ChartViewModel())
    }
    
    var body: some View {
        VStack {
            FilterView(selection: $viewModel.selectedServer)
                .padding(.bottom)
            
            if viewModel.prices.isEmpty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .albionBrown))
                    .foregroundStyle(.albionWhite)
                    .scaleEffect(2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text(.currentGoldPrice, with: (viewModel.lastPrice ?? 0))
                    .opacity(viewModel.lastPrice == nil ? 0 : 1)
                    .font(.title3)
                
                chartView
                    .background(chartBackground)
                    .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
                
                chartDateLabels
                    .padding(.horizontal, 4)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            viewModel.getGoldData()
        }
        .font(.caption)
        .foregroundColor(.albionBrown)
    }
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                let yAxis: CGFloat = CGFloat(viewModel.maxY - viewModel.minY)
                for index in viewModel.prices.indices {
                    let xPosition = geometry.size.width / CGFloat(viewModel.prices.count) * CGFloat(index + 1)
                    let yPosition = (1 - CGFloat(CGFloat((viewModel.prices[index] - viewModel.minY)) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: 1)
            .stroke(.albionBrown, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: .albionBrown, radius: 10, x: 0.0, y: 10)
            .shadow(color: .albionBrown.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: .albionBrown.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: .albionBrown.opacity(0.1), radius: 10, x: 0.0, y: 40)
            .drawingGroup()
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
            Spacer()
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
            Spacer()
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(viewModel.maxY.description)
            Spacer()
            Text(((viewModel.maxY + viewModel.minY) / 2).description)
                .offset(y: -15)
            Spacer()
//            Text(minY.description)
        }
    }
    
    @ViewBuilder
    private var chartDateLabels: some View {
        if let startDate = viewModel.startDate,
           let endDate = viewModel.endDate {
            HStack {
                Text(startDate.asShortDateString())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(endDate.asShortDateString())
            }
        }
    }
}

#Preview {
    ChartView()
}
