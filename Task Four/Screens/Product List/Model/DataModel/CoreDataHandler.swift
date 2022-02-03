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
        self.convertToCoreDataModel(products)
        self.saveProducts()
    }
    func convertToCoreDataModel(_ products: [ProductViewModel])
    {
        for product in products
        {
            let productModel = ProductModel(context: context)
            productModel.imageData = product.imageData
            productModel.price = Int16(product.price)
            productModel.productDescription = product.productDescription
            productModel.id = Int16(product.id)
            let img =  ProductImageModel(context: context)
            img.width = Int16(product.image.width)
            img.height = Int16(product.image.height)
            img.url = product.image.url
            productModel.productImage = img
        }
    }
    func saveProducts()
    {
        do
        {

        try context.save()
        }
        catch
        {
        print("Error saving Product \(error)")
        }
    }
    func getProductsFromCoreData(completion: @escaping ([ProductViewModel])->())
    {
        let request : NSFetchRequest<ProductModel> = ProductModel.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        do
        {
        let   products = try context.fetch(request)
        var  productsVM :[ProductViewModel] = []
        for product in products
        {
            let image = ProductImageViewModel(width: Int(product.productImage!.width), height: Int(product.productImage!.height), url: product.productImage!.url!)
            let productVM = ProductViewModel(price: Int(product.price), productDescription: product.productDescription!, imageData: product.imageData!, image: image, id: Int(product.id))
            productsVM.append(productVM)
            
        }
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
        }
        catch
        {
           print(error)
        }
    }
    
}
