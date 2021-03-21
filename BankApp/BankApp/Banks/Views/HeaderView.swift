//
//  HeaderView.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

import UIKit

class HeaderView: UICollectionReusableView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        backgroundColor = AppSettings.AppColor
        
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = AppSettings.HeaderTextColor
        titleLabel.font      = UIFont(name: "Verdana-Bold", size: 28)
    }
    
    func configureHeader(sectionType: AnyHashable) {
        if let header = sectionType as? BankSection {
            titleLabel.text = header.sectionTitle
        }
    }
}
