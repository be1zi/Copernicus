//
//  OverpassRemoteRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Moya

public enum OverpassRemoteRepository {
    case overpass(_ data: OverpassData)
}

extension OverpassRemoteRepository: TargetType {
        
    public var baseURL: URL {
        let urlString = ConfigurationManager.sharedInstance.serverAddress ?? ""
        return URL(string: urlString)!
    }
    
    public var path: String {
        return "/overpass/"
    }
    
    public var method: Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        
        switch self {
        case .overpass(let data):
            let params = ["api_key" : ConfigurationManager.sharedInstance.serverKey ?? "",
                          "bbox" : data.geometryString(),
                          "satellites" : data.satellitesString()]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
