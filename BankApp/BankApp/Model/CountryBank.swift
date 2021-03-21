//
//  CountryBank.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

/* Codable CountryBank to Save into CoreData */
struct CountryBank : Codable, Hashable {
    var country_code: String?            /* Country code compliant as ISO 3166-1 alpha-2 */
    var parent_banks: [BankGlobalGroup]? /* All banks from specific country */
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        parent_banks = try values.decodeIfPresent([BankGlobalGroup].self, forKey: .parent_banks)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: CountryBank, rhs: CountryBank) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
