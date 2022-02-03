//
//  ProductsListCollectionViewCell.swift
//  Task Four
//
//  Created by Mayar Adel on 1/29/22.
//

import UIKit

class ProductsListCollectionViewCell: UICollectionViewCell,ProductListCellView
{
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // configure cell ui
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = false
    }
    
    
    func configure(product: ProductViewModel)
    {
        
        productDescription.sizeToFit()
        productImage.frame.size.height = CGFloat(product.image.height)
        productPrice.text = String (product.price) + "$"
        productDescription.text = product.productDescription
        let imageData = product.imageData
        productImage.image = UIImage(data: imageData)
        
    }
    
}
