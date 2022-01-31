//
//  AppCoordinator.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import UIKit
class AppCoordinator: Coordinator
{
  // private(set) var childCoordinator: [Coordinator] = []
    private let window:UIWindow
    init(window:UIWindow)
    {
        self.window = window
    }
    func start()
    {
        let navigationController = UINavigationController()
        let productListCoordinator = ProductListCoordinator(navigationController: navigationController)
        productListCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
    
}
