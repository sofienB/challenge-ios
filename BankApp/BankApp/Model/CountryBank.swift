//
//  CountryBank.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

/* Codable CountryBank to Save into CoreData */
struct CountryBank : Codable {
    var country_code: String             /* Country code compliant as ISO 3166-1 alpha-2 */
    var parent_banks: [BankGlobalGroup]? /* All banks from specific country */
}
