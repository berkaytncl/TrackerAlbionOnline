//
//  View+Extensions.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 12.07.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<IfContent: View>(
        _ condition: Bool,
        transform: (Self) -> IfContent
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    @ViewBuilder
    func `if`<IfContent: View, ElseContent: View>(
        _ condition: Bool,
        transform: (Self) -> IfContent,
        else elseTransform: (Self) -> ElseContent
    ) -> some View {
        if condition {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
}
