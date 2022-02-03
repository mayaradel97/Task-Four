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
}
struct ProductImageViewModel
{
    let width: Int
    let height: Int
    let url: String
}
