//
//  BankGlobalGroup+CoreDataClass.swift
//  
//
//  Created by sofien Benharchache on 22/03/2021.
//
//

import Foundation
import CoreData

extension BankGlobalGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BankGlobalGroup> {
        return NSFetchRequest<BankGlobalGroup>(entityName: "BankGlobalGroup")
    }

    @NSManaged public var name: String?
    @NSManaged public var logo_url: String?
    @NSManaged public var banks: Set<Bank>?
    @NSManaged public var parent_banks: CountryBank?
}

// MARK: Generated accessors for banks
extension BankGlobalGroup {

    @objc(addBanksObject:)
    @NSManaged public func addToBanks(_ value: Bank)

    @objc(removeBanksObject:)
    @NSManaged public func removeFromBanks(_ value: Bank)

    @objc(addBanks:)
    @NSManaged public func addToBanks(_ values: NSSet)

    @objc(removeBanks:)
    @NSManaged public func removeFromBanks(_ values: NSSet)

}

@objc(BankGlobalGroup)
public class BankGlobalGroup: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo_url = "logo_url"
        case banks = "banks"
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard
            let contextUIK = CodingUserInfoKey.context,
            let context = decoder.userInfo[contextUIK] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "BankGlobalGroup", in: context)
        else {
            fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: context)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            name = try values.decodeIfPresent(String.self, forKey: .name)
            logo_url = try values.decodeIfPresent(String.self, forKey: .logo_url)
            banks = try values.decodeIfPresent(Set<Bank>.self, forKey: .banks)
        } catch {
            print ("error")
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(logo_url, forKey: .logo_url)
        try container.encode(banks, forKey: .banks)
    }

}
