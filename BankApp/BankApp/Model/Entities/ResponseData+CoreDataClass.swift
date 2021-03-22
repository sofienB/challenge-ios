//
//  ResponseData+CoreDataClass.swift
//  
//
//  Created by sofien Benharchache on 22/03/2021.
//
//

import Foundation
import CoreData

extension ResponseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResponseData> {
        return NSFetchRequest<ResponseData>(entityName: "ResponseData")
    }

    @NSManaged public var resources: Set<CountryBank>?

}

@objc(ResponseData)
public class ResponseData: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case resources = "resources"
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(resources, forKey: .resources)
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard
            let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "ResponseData", in: context)
        else {
            fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: context)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            resources = try values.decodeIfPresent(Set<CountryBank>.self, forKey: .resources)!
        } catch {
            print ("error")
        }
    }
}
