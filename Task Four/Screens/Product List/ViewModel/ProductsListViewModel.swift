//
//  ProductsListViewModel.swift
//  Task Four
//
//  Created by Mayar Adel on 1/28/22.
//

import Foundation
import Network
class ProductsListViewModel
{
    var bindProductsListToView: (()->())!
    var bindFailureToView: (()->())!
    var bindShowLoadingIndicatorToView: (()->())!
    var bindHideLoadingIndicatorToView: (()->())!
    var products: [ProductViewModel]
    var networkLayer: NetworkLayer!
    var productListCoordinator: ProductListCoordinator!
    var coreDataHandler: CoreDataHandler!
    init()
    {
        products = []
    }
    func checkNetworkConnectivity()
    {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor.pathUpdateHandler =
        { path in
            if path.status == .satisfied
            {
                self.getProductListFromNetwork()
                self.bindShowLoadingIndicatorToView()
                print("There is internet")
            }
            else
            {
                self.bindShowLoadingIndicatorToView()
                self.getProductListFromCoreData()
                print("No internet cashe data")
            }
        
        }
        monitor.start(queue: queue)
    }
    func getProductListFromCoreData()
    {
        coreDataHandler.getProductsFromCoreData
        { products in
            self.products = products
            print("cordata \(products.count)")
            print("cordata \(products[0].image.height)")
            self.bindProductsListToView()
            self.bindHideLoadingIndicatorToView()
        }
    }
    func getProductListFromNetwork()
    {
        self.bindShowLoadingIndicatorToView()
        let productsURL = URL(string: API.baseURL)!
        networkLayer.getResponse(of:[Product].self,url: productsURL)
        { [weak self] (products) in
            guard let self = self else {return}
            guard let productList = products
            else
            {
                //bind failure
                self.bindFailureToView()
                self.bindHideLoadingIndicatorToView()
                return
            }
        
            self.products += self.convertToProductViewModel(productList)
            self.bindProductsListToView()
            self.bindHideLoadingIndicatorToView()
            self.coreDataHandler.addProductsToCoreData(with: self.products)
           
        }
        
    }
    func convertToProductViewModel(_ products: [Product])->[ProductViewModel]
    {
        var productViewModelArray: [ProductViewModel]=[]
        for product in products
        {
            let imageData = self.getImageData(with: product.image.url)!
            let image = ProductImageViewModel(width: product.image.width, height: product.image.height, url: product.image.url)
            let product = ProductViewModel(price: product.price, productDescription: product.productDescription, imageData: imageData,image: image,id: product.id)
            productViewModelArray.append(product)
        }
        
        return productViewModelArray
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
    func configureCell(cell: ProductListCellView,indexPath:IndexPath)
    {
        cell.configure(product: products[indexPath.row])
    }
    func didSelectRow(at indexPath: IndexPath)
    {
        productListCoordinator.rowSelected(with:products[indexPath.row])
    }
}
