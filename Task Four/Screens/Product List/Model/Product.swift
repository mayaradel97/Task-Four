//
//  Product.swift
//  Task Four
//
//  Created by Mayar Adel on 1/28/22.
//

import Foundation
struct Product: Codable
{
    let image: productImage
    let price: Int
    let productDescription: String
    let id: Int
}
struct productImage: Codable
{
    let width: Int
    let height: Int
    let url: String
}
struct ProductViewModel
{
    let price: Int
    let productDescription: String
    let imageData: Data
    let image: ProductImageViewModel
    let id: Int
//    init( price: Int,productDescription: String, imageData: Data,image: ProductImageViewModel)
//    {
//        self.price = price
//        self.imageData = imageData
//        self.productDescription = productDescription
//        self.image = image
//    }
}
struct ProductImageViewModel
{
    let width: Int
    let height: Int
    let url: String
}
