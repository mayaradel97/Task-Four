//
//  CoreDataHandler.swift
//  Task Four
//
//  Created by Mayar Adel on 2/2/22.
//
import UIKit
import CoreData
class CoreDataHandler
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func addProductsToCoreData(with products: [ProductViewModel])
    {
        removeProductFromCoreData()
        for product in products
        {
            let date = Date()
            let productModel = ProductModel(context: context)
            productModel.imageData = product.imageData
            productModel.price = Int16(product.price)
            productModel.productDescription = product.productDescription
            productModel.date = date
            let img =  ProductImageModel(context: context)
            img.width = Int16(product.image.width)
            img.height = Int16(product.image.height)
            img.url = product.image.url
            productModel.productImage = img
        }
        print(products[0].image)
        self.saveProducts()
    }
    func saveProducts()
    {
        do
        {

        try context.save()
        print("save to core Data")
        }
        catch
        {
        print("Error saving Product \(error)")
        }
    }
    func getProductsFromCoreData(completion: @escaping ([ProductViewModel])->())
    {
        let request : NSFetchRequest<ProductModel> = ProductModel.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sort]
        do
        {
        let   products = try context.fetch(request)
        var  productsVM :[ProductViewModel] = []
        for product in products
        {
            let image = ProductImageViewModel(width: Int(product.productImage!.width), height: Int(product.productImage!.height), url: product.productImage!.url!)
            let productVM = ProductViewModel(price: Int(product.price), productDescription: product.productDescription!, imageData: product.imageData!, image: image)
            productsVM.append(productVM)
            
        }
        print("fetched")
        completion(productsVM)
        }
        catch
        {
            print("Error loading categories \(error)")
        }
    }
    func removeProductFromCoreData()
    {
        let deleteAllProducts = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "ProductModel"))
        do
        {
            try context.execute(deleteAllProducts)
            self.saveProducts()
            print("removed")
        }
        catch
        {
           print(error)
        }
    }
    
}