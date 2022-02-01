//
//  UIViewController+Alert.swift
//  Task Four
//
//  Created by Mayar Adel on 1/31/22.
//

import UIKit
extension UIViewController
{
    func showAlert(with message:String)
    {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
  static  func instantiate<T>(storyBoardName name: String)->T
    {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewControllerIdentifier = String(describing:T.self)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerIdentifier) as! T
        return viewController
        
    }
    
}
