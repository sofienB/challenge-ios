//
//  NetworkManager.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation
import BSNetworking
import CoreData

extension NSManagedObject {
  func toJSON() -> String? {
    let keys = Array(self.entity.attributesByName.keys)
    let dict = self.dictionaryWithValues(forKeys: keys)
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let reqJSONStr = String(data: jsonData, encoding: .utf8)
        return reqJSONStr
    }
    catch{}
    return nil
  }
}

enum NetworkResponse:String, Equatable {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

protocol NetworkManagerProtocol {
    associatedtype EndPoint: EndPointType

    static var environement : NetworkEnvironment { get }
    static var ClientID: String { get }

    var router: Router<EndPoint> { get }
    
}
extension CodingUserInfoKey {
   static let context = CodingUserInfoKey(rawValue: "context")
}
struct NetworkManager:NetworkManagerProtocol {
    static let environement : NetworkEnvironment = .production
    static let ClientID = "dd6696c38b5148059ad9dedb408d6c84"

    let router = Router<BankApi>()

    private let decoder = JSONDecoder()
    var container = NSPersistentContainer(name: "BankApp")

    func fetchBanks(completion: @escaping (_ bank: [CountryBank]?,_ error: NetworkResponse?)->()){

        let bankResources: NSFetchRequest<ResponseData> = ResponseData.fetchRequest()
        do {
            let countryBank = try PersistenceService.context.fetch(bankResources)
            if !countryBank.isEmpty {
                completion(Array(countryBank.first!.resources!), NetworkResponse.success)
                return
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        router.request(.banks) { data, response, error in
            if error != nil {
                completion(nil, NetworkResponse.failed)
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData)
                        return
                    }
                    do {
                        decoder.userInfo[CodingUserInfoKey.context!] = PersistenceService.context

                        let jsonData = try decoder.decode(ResponseData.self, from: responseData)
                        PersistenceService.saveContext()
                        completion(Array(jsonData.resources!), NetworkResponse.success)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode)
                    }
                case .failure(let networkFailureError):
                    completion(nil, NetworkResponse(rawValue: networkFailureError))
                }
            }
        }
    }

    fileprivate func handleNetworkResponse(_ response:HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
