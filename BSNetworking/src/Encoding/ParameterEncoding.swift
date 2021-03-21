//
//  ParameterEncoding.swift
//  BSConnectionCoordinator
//
//  Created by sofien benharchache on 05/12/2018.
//  Copyright © 2018 sofien benharchache. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters:Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
