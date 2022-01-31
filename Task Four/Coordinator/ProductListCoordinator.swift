//
//  ProductListCoordinator.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import UIKit
class ProductListCoordinator:Coordinator
{
   //private(set) var childCoordinator: [Coordinator] = []
    private let navigationController:UINavigationController
    init(navigationController:UINavigationController)
    {
        self.navigationController = navigationController
    }
    func start()
    {
     let productListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProductListViewController") as! ProductListViewController
        navigationController.setViewControllers([productListVC], animated: false)
        let productListVM = ProductsListViewModel()
        productListVC.productsListVM = productListVM
        
    }
    
    
}
