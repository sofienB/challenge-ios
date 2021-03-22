//
//  CountryBank+CoreDataClass.swift
//  
//
//  Created by sofien Benharchache on 22/03/2021.
//
//

import Foundation
import CoreData

extension CountryBank {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryBank> {
        return NSFetchRequest<CountryBank>(entityName: "CountryBank")
    }

    @NSManaged public var country_code: String?
    @NSManaged public var parent_banks: Set<BankGlobalGroup>?
    @NSManaged public var resources: ResponseData?
}

// MARK: Generated accessors for parent_banks
extension CountryBank {
    @objc(addParent_banksObject:)
    @NSManaged public func addToParent_banks(_ value: BankGlobalGroup)

    @objc(removeParent_banksObject:)
    @NSManaged public func removeFromParent_banks(_ value: BankGlobalGroup)

    @objc(addParent_banks:)
    @NSManaged public func addToParent_banks(_ values: NSSet)

    @objc(removeParent_banks:)
    @NSManaged public func removeFromParent_banks(_ values: NSSet)
}

@objc(CountryBank)
public class CountryBank: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case country_code = "country_code"
        case parent_banks = "parent_banks"
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard
            let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "CountryBank", in: context)
        else {
            fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: context)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
            parent_banks = try values.decodeIfPresent(Set<BankGlobalGroup>.self, forKey: .parent_banks)
        } catch {
            print ("error")
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(country_code, forKey: .country_code)
        try container.encode(parent_banks, forKey: .parent_banks)
    }

}
