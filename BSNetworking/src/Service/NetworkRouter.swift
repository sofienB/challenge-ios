//
//  NetworkRouter.swift
//  BSConnectionCoordinator
//
//  Created by sofien benharchache on 05/12/2018.
//  Copyright © 2018 sofien benharchache. All rights reserved.
//

import Foundation
public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

public enum NetworkEnvironment {
    case qa
    case production
    case staging
}
