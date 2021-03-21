//
//  BankEndPoint.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation
import BSNetworking

public enum BankApi {
    case bank(id:Int)
    case banks
    case banksWithFirst(country: String)
}

extension BankApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environement {
        case .production: return "https://sync.bankin.com/v2/banks"
        case .qa: return "https://sync.bankin.com/v2/banks"
        case .staging: return "https://sync.bankin.com/v2/banks"
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    public var path: String {
        switch self {
        case .bank(id: let id):
            return "\(id)"
        case .banks:
            return ""
        case .banksWithFirst(country: let country):
            return "\(country)"
        }
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var task: HTTPTask {
        switch self {
        case .banks:
            let bankinVersion = "2019-02-18"
            let clientSecret = "56uolm946ktmLTqNMIvfMth4kdiHpiQ5Yo8lT4AFR0aLRZxkxQWaGhLDHXeda6DZ"

            return
                .requestParametersAndHeaders(bodyParameters:nil,
                                             urlParameters:["limit":"100"],
                                            additionHeaders: ["Bankin-Version":bankinVersion,
                                                             "Client-Id":NetworkManager.ClientID,
                                                             "Client-Secret":clientSecret])
        default:
            return .request
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
