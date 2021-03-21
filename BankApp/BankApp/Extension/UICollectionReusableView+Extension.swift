//
//  UICollectionReusableView+Extension.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

import UIKit

extension UICollectionReusableView {
    static var nibName: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
