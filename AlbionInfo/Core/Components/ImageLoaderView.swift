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
                .retryOnAppear(true)
                .indicator(.activity)
                .aspectRatio(contentMode: .fit)
                .allowsTightening(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView(uniqueItemName: LocalizedItem.mock.uniqueName) {
        PlaceholderView()
    }
    .clipShape(RoundedRectangle(cornerRadius: 30))
    .padding(40)
    .padding(.vertical, 60)
}
