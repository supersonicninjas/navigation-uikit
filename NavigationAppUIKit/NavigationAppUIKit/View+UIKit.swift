//
//  View+UIKit.swift
//  NavigationAppUIKit
//
//  Created by Mirza Učanbarlić on 24. 2. 2024..
//
import UIKit
import SwiftUI

extension View {
    func toHostingViewController() -> UIHostingController<Self> {
        let hostingViewController = UIHostingController(rootView: self)
        return hostingViewController
    }
}
