//
//  ProductListCoordinator.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import UIKit
class ProductListCoordinator:Coordinator
{
    private let navigationController:UINavigationController
    init(navigationController:UINavigationController)
    {
        self.navigationController = navigationController
    }
    func start()
    {
        let productListVC:ProductListViewController = .instantiate(storyBoardName: "Main")
        
        navigationController.setViewControllers([productListVC], animated: false)
        let productListVM = ProductsListViewModel()
        productListVC.productsListVM = productListVM
        productListVM.productListCoordinator = self
        
    }
    func rowSelected(with product: Product)
    {
        let productDetailsCoordinator = ProductDetailsCoordinator(navigationController: navigationController, product: product)
        productDetailsCoordinator.start()
        
    }
    
}
