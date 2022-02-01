//
//  Product.swift
//  Task Four
//
//  Created by Mayar Adel on 1/28/22.
//

import Foundation
class Product:Codable
{
    let image: productImage
    let price: Int
    let productDescription: String
    var imageData: Data?
    
    
}
struct productImage:Codable
{
    let width: Int
    let height: Int
    let url: String
}
