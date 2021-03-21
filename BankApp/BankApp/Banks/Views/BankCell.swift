//
//  BankCell.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import UIKit

class BankCell: UICollectionViewCell {
    lazy var bankView: BankView = {
        let bank = BankView()
        bank.frame.size = contentView.bounds.size
        bank.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return bank
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bankView)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with bank: Bank) {
        bankView.name.text = bank.name
        bankView.bankID.text = String(bank.id!)
        bankView.localName.text = bank.subName
        
        guard let url = URL(string: bank.logo_url!) else { return }
        
        bankView.imageView.load(url: url)
        bankView.imageView.contentMode = .scaleAspectFit
    }
}
