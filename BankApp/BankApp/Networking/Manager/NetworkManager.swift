//
//  NetworkManager.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation
import BSNetworking

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

struct NetworkManager:NetworkManagerProtocol {
    static let environement : NetworkEnvironment = .production
    static let ClientID = "dd6696c38b5148059ad9dedb408d6c84"
    
    let router = Router<BankApi>()
    
    private let decoder = JSONDecoder()

    func fetchBanks(completion: @escaping (_ bank: [CountryBank]?,_ error: NetworkResponse?)->()){
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
                        let jsonData = try decoder.decode(ResponseData.self, from: responseData)
                        completion(jsonData.resources, NetworkResponse.success)
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
