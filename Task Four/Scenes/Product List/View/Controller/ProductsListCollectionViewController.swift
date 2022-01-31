//
//  ProductsListCollectionViewController.swift
//  Task Four
//
//  Created by Mayar Adel on 1/28/22.
//

import UIKit

private let reuseIdentifier = "ProductsListCell"

class ProductsListCollectionViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var productsListVM :ProductsListViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: String(describing: ProductsListCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductsListCollectionViewCell.self))
        productsListVM = ProductsListViewModel()
        productsListVM.getProductsListFromNetwork()
        self.bindProductsList()
        self.bindFailure()
        self.loadingIndicator.startAnimating()
    }
    func bindFailure()
    {
        productsListVM.bindFailureToView =
            {
                [weak self] in
                guard let self = self else {return}
                self.showAlert(with: "No Internt Connection")
            }
    }
    func bindProductsList()
    {
        productsListVM.bindProductsListToView =
            {
                [weak self]  in
                guard let self = self else {return}
                
                DispatchQueue.main.async
                {
                    self.collectionView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
                
            }
        
    }
    
    
}


// MARK: UICollectionViewDataSource
extension ProductsListCollectionViewController :UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return productsListVM.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productsListCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductsListCollectionViewCell.self), for: indexPath) as! ProductsListCollectionViewCell
        productsListVM.configureCell(cell: productsListCell, indexPath: indexPath)
        return productsListCell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if indexPath.row == productsListVM.products.count - 1
        {
            self.productsListVM.getProductsListFromNetwork()
            self.loadingIndicator.startAnimating()
            
        }
    }
    
}
// MARK: UICollectionViewDelegate
extension ProductsListCollectionViewController:UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
    
}
// MARK: UICollectionViewDelegateFlowLayout
extension ProductsListCollectionViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  2
        let collectionViewSize = collectionView.frame.size.width - padding
               
        return CGSize(width: collectionViewSize/2, height: collectionViewSize + 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets.zero
        
    }
}
