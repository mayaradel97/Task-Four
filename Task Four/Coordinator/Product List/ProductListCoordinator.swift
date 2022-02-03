//
//  ProductListCoordinator.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import UIKit
class ProductListCoordinator: Coordinator
{
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    func start()
    {
        let productListVC: ProductListViewController = .instantiate(storyBoardName: "Main")
        navigationController.setViewControllers([productListVC], animated: false)
        let productListViewModel = ProductsListViewModel()
        productListVC.productListViewModel = productListViewModel
        productListViewModel.productListCoordinator = self
        let networkLayer = NetworkLayer()
        productListViewModel.networkLayer = networkLayer
        let coreDataHandler = CoreDataHandler()
        productListViewModel.coreDataHandler = coreDataHandler
    }
    func rowSelected(with product: ProductViewModel)
    {
        let productDetailsCoordinator = ProductDetailsCoordinator(navigationController: navigationController, product: product)
        productDetailsCoordinator.start()
        
    }
    
}
