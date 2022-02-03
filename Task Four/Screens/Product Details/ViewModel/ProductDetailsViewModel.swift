//
//  ProductDetailsViewModel.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import Foundation
class ProductDetailsViewModel
{
    private let product: ProductViewModel
    var bindProductDetailsToView: (()->())!
    var imageData: Data
    {
       return product.imageData
    }
    var productDescription:String
    {
        return product.productDescription
    }
    init(product: ProductViewModel)
    {
        self.product = product
      
    }
    func viewDidLoad()
    {
        self.bindProductDetailsToView()
    }

}
