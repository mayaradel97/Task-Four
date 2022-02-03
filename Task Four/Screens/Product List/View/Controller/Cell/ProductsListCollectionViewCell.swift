//
//  ProductsListCollectionViewCell.swift
//  Task Four
//
//  Created by Mayar Adel on 1/29/22.
//

import UIKit

class ProductsListCollectionViewCell: UICollectionViewCell,ProductListCellView
{
    
    
    @IBOutlet weak var backgoroundView: UIView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
      //  backgoroundView.clipsToBounds = true
        
     //   self.contentView.layer.shadowOpacity = 0.5
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
