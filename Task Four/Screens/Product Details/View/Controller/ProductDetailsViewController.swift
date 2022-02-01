//
//  ProductDetailsViewController.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var productDetailsViewModel:ProductDetailsViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.bindProductDetails()
        productDetailsViewModel.viewDidLoad()
    }
    func bindProductDetails()
    {
        productDetailsViewModel.bindProductDetailsToView =
            {[weak self] in 
                guard let self = self else {return}
                self.productImage.image = UIImage(data:self.productDetailsViewModel.imageData)
                self.productDescription.text = self.productDetailsViewModel.productDescription
            }
    }
}
