//
//  ResponseData.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

struct ResponseData: Decodable {
    var resources: [CountryBank] /* Banks listed by country */
}
