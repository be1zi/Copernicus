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
        
        switch self {
        case .overpass(let data):
            let apiKey = "api_key=" + (ConfigurationManager.sharedInstance.serverKey ?? "")
            let bbox = "bbox=" + data.geometryString()
            let satellites = "satellites=" + data.satellitesString()
            
            return "/overpass/?\(apiKey)&\(bbox)&\(satellites)"
        }
    }
    
    public var method: Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
