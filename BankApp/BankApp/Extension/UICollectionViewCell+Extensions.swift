//
//  UICollectionViewCell+Extensions.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import UIKit

extension UICollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
