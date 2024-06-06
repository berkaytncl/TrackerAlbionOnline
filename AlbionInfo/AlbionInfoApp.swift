//
//  AlbionInfoApp.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 6.06.2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct AlbionInfoApp: App {    
    var body: some Scene {
        WindowGroup {
            RouterView { router in
                RootView(router: router)
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
