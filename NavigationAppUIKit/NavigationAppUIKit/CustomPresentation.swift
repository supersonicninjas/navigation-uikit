//
//  CustomPresentation.swift
//  NavigationAppUIKit
//
//  Created by Mirza Učanbarlić on 8. 3. 2024..
//

import UIKit

final class CustomPresentationController: UIPresentationController {
    
    private struct Layout {
        static let height: CGFloat = 50
        static let width: CGFloat = 50
    }
        
    override func containerViewWillLayoutSubviews() {
        let initialFrame = calculateInitialFrame()
        presentedView?.frame = initialFrame
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self else {
                return
            }
            presentedView?.frame = self.containerView?.frame ?? .zero
        }
    }
    
    private func calculateInitialFrame() -> CGRect {
        let bounds  = self.containerView?.bounds ?? .zero
        let initialFrame  = CGRectMake(
            bounds.midX,
            bounds.midY,
            Layout.height,
            Layout.width
        )
        return initialFrame
    }
}
    
final class CustomPresentationTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
