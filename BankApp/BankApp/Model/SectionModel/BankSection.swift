//
//  BankSection.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

class BankSection: Hashable {
    
    var sectionTitle: String = "Banks"
    var banks: [Bank]?
    
    init(banks: [Bank], countryCode:String) {
        let country: String = BALocation.getCountry(from: countryCode) ?? countryCode

        self.banks = banks
        self.sectionTitle = "From \(country)"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: BankSection, rhs: BankSection) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
