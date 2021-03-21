//
//  BankView.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import UIKit

class BankView: LoadableView {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bankID: UILabel!
    @IBOutlet weak var localName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setup()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    func setup() {
        backgroundColor    = AppSettings.HeaderTextColor
        let textColor      = AppSettings.TextColor
        let textLightColor = AppSettings.TextLightColor

        name.textColor      = textColor
        bankID.textColor    = textLightColor
        localName.textColor = textLightColor
        
        name.font      = UIFont(name: "Verdana-Bold", size: 20)
        bankID.font    = UIFont(name: "Verdana-Bold", size: 15)
        localName.font = UIFont(name: "Verdana-Bold", size: 15)
    }
    
    func configureView() {
        layer.cornerRadius = 10;
        layer.masksToBounds = true;
    }
}
