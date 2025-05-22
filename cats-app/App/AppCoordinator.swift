//
//  AppCoordinator.swift
//  cats-app
//
//  Created by Edson Brandon on 22/05/25.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}


class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}
