//
//  ImageLoaderView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView<Placeholder: View>: View {
    let urlString: String
    var placeholder: Placeholder
    
    init(uniqueItemName: String?, quality: Int? = nil, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.placeholder = placeholder()
        
        guard let uniqueItemName else {
            urlString = ""
            return
        }
        if let quality {
            urlString = "https://render.albiononline.com/v1/item/\(uniqueItemName).png?quality=\(quality)"
        } else {
            urlString = "https://render.albiononline.com/v1/item/\(uniqueItemName).png"
        }
    }
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: URL(string: urlString)) { image in
                    image.resizable()
                } placeholder: {
                    placeholder
                }
                .indicator(.activity)
                .aspectRatio(contentMode: .fit)
                .allowsTightening(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView(uniqueItemName: LocalizedItem.mock.uniqueName) {
        Rectangle()
            .foregroundColor(.gray)
            .frame(width: 50, height: 50)
            .overlay {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .albionBrown))
                    .foregroundStyle(.albionWhite)
                    .scaleEffect(1.5)
                    .padding(.bottom, 8)
            }
    }
    .clipShape(RoundedRectangle(cornerRadius: 30))
    .padding(40)
    .padding(.vertical, 60)
}
