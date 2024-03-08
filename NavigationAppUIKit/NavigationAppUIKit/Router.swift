//
//  Router.swift
//  NavigationAppUIKit
//
//  Created by Mirza Učanbarlić on 24. 2. 2024..
//

import UIKit
import SwiftUI

enum Destination: Identifiable, CaseIterable {
    case one
    case two
    case three
    
    var id: String { String(describing: self) }
    
    var title: String {
        switch self {
        case .one:
            return "One"
        case .two:
            return "Two"
        case .three:
            return "Three"
        }
    }
}

final class Router: ObservableObject {
    private let window: UIWindow
    private (set) var stack: [Destination] = []
    private(set) var presentedDestination: Destination? = nil
    private(set) var navigationController = UINavigationController()
    private let customPresentationTransitionDelegate = CustomPresentationTransitionDelegate()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        let rootView = ContentView().environmentObject(self)
        navigationController.viewControllers = [rootView.toHostingViewController()]
        window.makeKeyAndVisible()
    }
    
    func present(_ destination: Destination, animated: Bool = true, completion: (() -> Void)? = nil) {
        let view = domainView(for: destination)
        navigationController.present(view, animated: animated, completion: completion)
    }
    
    func sheet<T: View>(_ view: T, detents: [UISheetPresentationController.Detent] = [.medium()], animated: Bool = true, completion: (() -> Void)? = nil) {
        let view = view.toHostingViewController()
        view.modalPresentationStyle = .pageSheet
        if let sheet = view.sheetPresentationController {
            sheet.detents = detents
        }
        navigationController.present(view, animated: animated, completion: completion)
    }
    
    func present<T: View>(_ view: T, animated: Bool = true, completion: (() -> Void)? = nil) {
        let view = view.toHostingViewController()
        navigationController.present(view, animated: animated, completion: completion)
    }
    
    func customPresent<T: View>(_ view: T, animated: Bool = true, completion: (() -> Void)? = nil) {
        let view = view.toHostingViewController()
        view.modalPresentationStyle = .custom
        view.transitioningDelegate = customPresentationTransitionDelegate
        navigationController.present(view, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ destination: Destination, animated: Bool = true) {
        let view = domainView(for: destination)
        navigationController.pushViewController(view, animated: animated)
        stack.append(destination)
    }
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
        _ = stack.popLast()
    }
    
    func setRoot(_ destination: Destination, animated: Bool) {
        let viewController = domainView(for: destination)
        stack.removeAll()
        stack.append(destination)
        window.rootViewController = viewController
    }
    
    func domainView(for destination: Destination) -> UIViewController {
        switch destination {
        case .one:
            let screenOneView = ScreenOneView().environmentObject(self)
            return screenOneView.toHostingViewController()
        case .two:
            let screenTwoView = ScreenTwoView().environmentObject(self)
            return screenTwoView.toHostingViewController()
        case .three:
            let screenThreeView = ScreenThreeView().environmentObject(self)
            return screenThreeView.toHostingViewController()
        }
    }
}
