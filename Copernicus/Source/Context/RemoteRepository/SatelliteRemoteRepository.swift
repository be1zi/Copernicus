//
//  SatelliteRemoteRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 30/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import Moya

public enum SatelliteRemoteRepository {
    case allSatellites
}

extension SatelliteRemoteRepository: TargetType {
        
    public var baseURL: URL {
        let urlString = ConfigurationManager.sharedInstance.serverAddress ?? ""
        return URL(string: urlString)!
    }
    
    public var path: String {
        return "/satellite"
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
