//
//  ProductDetailsCoordinator.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import UIKit
class ProductDetailsCoordinator:Coordinator
{
    private let navigationController :UINavigationController
    private let product:Product
    init(navigationController :UINavigationController,product:Product)
    {
        self.navigationController = navigationController
        self.product = product
    }
    func start()
    {
        let productDetailsVC:ProductDetailsViewController = .instantiate(storyBoardName: "ProductDetailsStoryboard")
        let productDetailsVM = ProductDetailsViewModel(product: product)
        productDetailsVC.productDetailsViewModel = productDetailsVM
      self.navigationController.pushViewController(productDetailsVC, animated: false)
    }
}
