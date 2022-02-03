//
//  ProductsListCollectionViewController.swift
//  Task Four
//
//  Created by Mayar Adel on 1/28/22.
//

import UIKit

class ProductListViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var productListViewModel :ProductsListViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.bindProductsList()
        self.bindFailure()
        self.bindLoadingIndicator()
        self.bindHideLoadingIndicator()
        productListViewModel.checkNetworkConnectivity()
        self.cellResiteration()
    }
    func cellResiteration()
    {
        collectionView.register(UINib(nibName: String(describing: ProductsListCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductsListCollectionViewCell.self))
    }
// MARK: binding methods
    func bindFailure()
    {
        productListViewModel.bindFailureToView =
            {
                [weak self] in
                guard let self = self else {return}
                DispatchQueue.main.async
                {
                self.showAlert(with: "No Internt Connection")
                }
            }
    }
    func bindLoadingIndicator()
    {
        productListViewModel.bindShowLoadingIndicatorToView =
            {
                [weak self] in
                guard let self = self else {return}
                DispatchQueue.main.async
                {
                    self.loadingIndicator.startAnimating()
                }
            }
        
    }
    func bindHideLoadingIndicator()
    {
        productListViewModel.bindHideLoadingIndicatorToView =
            {
                [weak self] in
                guard let self = self else {return}
                DispatchQueue.main.async
                {
                    self.loadingIndicator.stopAnimating()
                }
            
            }
    }
    func bindProductsList()
    {
        productListViewModel.bindProductsListToView =
            {
                [weak self]  in
                guard let self = self else {return}
                
                DispatchQueue.main.async
                {
                    self.collectionView.reloadData()
                }
                
            }
        
    }
    
    
}


// MARK: UICollectionViewDataSource
extension ProductListViewController :UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return productListViewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let productsListCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductsListCollectionViewCell.self), for: indexPath) as! ProductsListCollectionViewCell
        productListViewModel.configureCell(cell: productsListCell, indexPath: indexPath)
        
        return productsListCell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if indexPath.row == productListViewModel.products.count - 1
        {
            self.productListViewModel.getProductListFromNetwork()
        }
    }
    
}
// MARK: UICollectionViewDelegate
extension ProductListViewController:UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        productListViewModel.didSelectRow(at: indexPath)
    }
    
    
}
// MARK: UICollectionViewDelegateFlowLayout
extension ProductListViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  2
        let collectionViewSize = collectionView.frame.size.width - padding
               
        return CGSize(width: collectionViewSize/2, height: collectionViewSize + 250)
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
