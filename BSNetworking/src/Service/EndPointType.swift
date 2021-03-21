//
//  EndPointType.swift
//  BSConnectionCoordinator
//
//  Created by sofien benharchache on 04/12/2018.
//  Copyright © 2018 sofien benharchache. All rights reserved.
//

import Foundation
public protocol EndPointType {
    var baseURL : URL { get }
    var path : String { get }
    var httpMethod : HTTPMethod { get }
    var task : HTTPTask { get }
    var headers : HTTPHeaders? { get }
}
