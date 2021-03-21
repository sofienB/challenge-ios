//
//  UIColor+Extension.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import UIKit

extension UIColor {
    static func rgbColor(red: CGFloat, green: CGFloat,
                           blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0,
                      blue: blue/255.0, alpha: alpha)
    }
}
