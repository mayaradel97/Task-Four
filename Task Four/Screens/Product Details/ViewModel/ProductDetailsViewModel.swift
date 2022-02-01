//
//  ProductDetailsViewModel.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import Foundation
class ProductDetailsViewModel
{
    private let product: Product
    var bindProductDetailsToView: (()->())!
    var imageData:Data
    {
        return product.imageData!
    }
    var productDescription:String
    {
        return product.productDescription
    }
    init(product:Product)
    {
        self.product = product
      
    }
    func viewDidLoad()
    {
        self.bindProductDetailsToView()
    }

}
