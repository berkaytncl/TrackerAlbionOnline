//
//  FilterView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 12.07.2024.
//

import SwiftUI

struct FilterView<T: Filter>: View {
    @Binding var selection: T
    @Namespace private var namespace
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(T.allCases, id: \.self) { option in
                    VStack(spacing: 8) {
                        Text(option.localizedDescription)
                            .frame(maxWidth: .infinity)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        if selection == option {
                            RoundedRectangle(cornerRadius: 2)
                                .frame(height: 1.5)
                                .matchedGeometryEffect(id: "selection", in: namespace)
                        }
                    }
                    .padding(.top, 8)
                    .foregroundStyle(selection == option ? .albionBrown : .albionBrown.opacity(0.5))
                    .background(.albionDarkBrown.opacity(0.001))
                    .onTapGesture {
                        selection = option
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .animation(.smooth, value: selection)
    }
}

#Preview {
    @State var selection: ReportsType = .both
    
    return FilterView(selection: $selection)
        .padding()
}
