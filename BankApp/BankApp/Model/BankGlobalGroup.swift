//
//  BankGlobalGroup.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

/* Codable BankGlobalGroup to Save into CoreData */
struct BankGlobalGroup : Codable, Hashable {
    var name: String?       /* Bank name */
    var logo_url: String?   /* Logo bank url */
    var banks: [Bank]?      /* Local banks */
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        logo_url = try values.decodeIfPresent(String.self, forKey: .logo_url)
        banks = try values.decodeIfPresent([Bank].self, forKey: .banks)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: BankGlobalGroup, rhs: BankGlobalGroup) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
