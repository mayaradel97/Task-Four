//
//  ProductsListViewModel.swift
//  Task Four
//
//  Created by Mayar Adel on 1/28/22.
//

import Foundation
class ProductsListViewModel
{
    var bindProductsListToView: (()->())!
    var bindFailureToView: (()->())!
    var products: [Product]
    var networkLayer: NetworkLayer!
    var productListCoordinator: ProductListCoordinator!
    init()
    {
        products = []
    }
    func configureCell(cell: ProductListCellView,indexPath:IndexPath)
    {
        cell.configure(product: products[indexPath.row])
    }
    func getProductsListFromNetwork()
    {
        let productsURL = URL(string: API.baseURL)!
        networkLayer.getProductsList(of:[Product].self,url: productsURL)
        { [weak self] (products) in
            guard let self = self else {return}
            guard let productsList = products
            else
            {
                //bind failure
                self.bindFailureToView()
                return
            }
            for product in productsList
            {
                product.imageData = self.getImageData(with: product.image.url)!
            }
            self.products += productsList
            self.bindProductsListToView()
        }
        
    }
    func getImageData(with url: String)-> Data?
    {
        let url = URL(string: url)
        guard let imageURL = url
        else
        {
            return nil
        }
       guard let imageData = try? Data(contentsOf: imageURL)
        else
       {
        return nil
       }
        return imageData
    }
    func didSelectRow(at indexPath: IndexPath)
    {
        productListCoordinator.rowSelected(with:products[indexPath.row])
    }
}
