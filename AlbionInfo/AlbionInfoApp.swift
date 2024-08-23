//
//  AlbionInfoApp.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 6.06.2024.
//

import SwiftUI

@main
struct AlbionInfoApp: App {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.albionBrown.opacity(0.5))
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
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
