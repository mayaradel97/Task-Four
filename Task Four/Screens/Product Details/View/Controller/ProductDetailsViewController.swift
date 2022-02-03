//
//  ProductDetailsViewController.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import UIKit

class ProductDetailsViewController: UIViewController
{
    /// @brief ProductDetailsViewController's outlet
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    /// @brief reference to ViewModel
    var productDetailsViewModel: ProductDetailsViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.bindProductDetails()
        productDetailsViewModel.viewDidLoad()
    }
    /**
     *@discussion bind product details controller with ViewModel
     so it will update the screen with product details
     *@return void
     */
    func bindProductDetails()
    {
        productDetailsViewModel.bindProductDetailsToView =
            {[weak self] in 
                guard let self = self else {return}
                self.productDescription.text = self.productDetailsViewModel.productDescription
               let imageData = self.productDetailsViewModel.imageData
               self.productImage.image = UIImage(data: imageData)
               
            }
    }
}
