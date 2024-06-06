//
//  SearchBarView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.07.2024.
//

import SwiftUI

struct SearchBarView: View {
    var prompt: String
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? .albionDarkBrown.opacity(0.5) : .albionDarkBrown
                )
            
            TextField(text: $searchText, axis: .horizontal) {
                Text(prompt)
                    .foregroundStyle(.albionDarkBrown.opacity(0.5))
            }
            .autocorrectionDisabled()
            .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
                , alignment: .trailing
            )
        }
        .animation(.bouncy, value: searchText)
        .font(.headline)
        .foregroundStyle(.albionDarkBrown)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.albionBrown)
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
}

#Preview {
    SearchBarView(prompt: "", searchText: .constant(""))
}
