//
//  ProductDetailsTests.swift
//  ProductDetailsTests
//
//  Created by Mayar Adel on 2/2/22.
//

import XCTest
@testable import Task_Four
class ProductDetailsTests: XCTestCase
{
    var productDetailsViewModel: ProductDetailsViewModel!
    var productViewModel: ProductViewModel!
    var productImageViewModel: ProductImageViewModel!
    var imageData: Data!
    var productsURL: URL!
    var coreDataHandler: CoreDataHandler!
    var networkHandler: NetworkLayer!
    
    override func setUpWithError() throws
    {
        coreDataHandler = CoreDataHandler()
        networkHandler = NetworkLayer()
        productsURL = URL(string: API.baseURL)!
    }
    
    override func tearDownWithError() throws
    {
        productDetailsViewModel = nil
        productViewModel = nil
        productImageViewModel = nil
        imageData = nil
        productsURL = nil
        coreDataHandler = nil
        networkHandler = nil
    }
    
    func testWhenGettingProductDetailsFromNetwork() throws
    {
        let expectationObject = expectation(description: "waiting for api response")
        networkHandler.getResponse(of:[Product].self,url: productsURL)
        { [weak self] (products) in
            guard let self = self else {return}
            guard let productList = products
            else
            {
                return
            }
            self.setProductsFromNetworkToProductViewModel(productList)
            XCTAssertGreaterThan(productList.count, 0)
            XCTAssertNotNil(self.productDetailsViewModel.imageData, "image data has value")
            XCTAssertGreaterThan(self.productDetailsViewModel.productDescription.count, 0)
            XCTAssertNil(self.productDetailsViewModel.bindProductDetailsToView)
            expectationObject.fulfill()
        }

        waitForExpectations(timeout: 50)
    }

    func testWhenGettingProductDetailsFromCoreData()
    {
        coreDataHandler.getProductsFromCoreData
        {
            [weak self] (products) in
            guard let self = self else {return}
            self.setProductsFromCoreDataToProductDetailsViewModel(products)
            XCTAssertNotNil(self.productDetailsViewModel.imageData, "image data has value")
            XCTAssertGreaterThan(self.productDetailsViewModel.productDescription.count, 0)
            XCTAssertNil(self.productDetailsViewModel.bindProductDetailsToView)
        }
        
    }
    func setProductsFromCoreDataToProductDetailsViewModel(_ products: [ProductViewModel])
    {
        let product = products[1]
        self.productViewModel = ProductViewModel(price: product.price, productDescription: product.productDescription, imageData: product.imageData, image: product.image, id: product.id)
        self.productDetailsViewModel = ProductDetailsViewModel(product:self.productViewModel )
    }
    func setProductsFromNetworkToProductViewModel(_ products: [Product])
    {
        let product = products[0]
        self.productImageViewModel = ProductImageViewModel(width: product.image.width, height: product.image.height, url: product.image.url)
        self.imageData = try? Data(contentsOf:URL(string: product.image.url)! )
        self.productViewModel = ProductViewModel(price: product.price, productDescription: product.productDescription, imageData: self.imageData, image:self.productImageViewModel, id: product.id)
        self.productDetailsViewModel = ProductDetailsViewModel(product:self.productViewModel )
    }
}
