//
//  NavigationController.swift
//  DeliverForMe
//
//  Created by Sowrirajan S on 18/07/20.
//  Copyright © 2020 optisol. All rights reserved.
//

import UIKit
extension UINavigationController {
    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return self.viewControllers.first(where: { $0 is T })
    }

    func popToViewController<T: UIViewController>(of type: T.Type, animated: Bool) {
        guard let viewController = self.getViewController(of: type) else { return }
        self.popToViewController(viewController, animated: animated)
    }
}
