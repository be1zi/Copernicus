//
//  ImageryRemoteRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 14/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Moya

public enum ImageryRemoteRepository {
    case imagery(_ data: CloudyData, page: Int)
    case filesList(_ imageId: Int)
}

extension ImageryRemoteRepository: TargetType {
    
    public var baseURL: URL {
        let urlString = ConfigurationManager.sharedInstance.serverAddress ?? ""
        return URL(string: urlString)!
    }
    
    public var path: String {
        
        switch self {
        case .imagery(_, page: _):
            return "/imagery/"
        case .filesList(let imageId):
            return "/imagery/\(imageId)/files/"
        }
    }
    
    public var method: Method {
        .get
    }
    
    public var sampleData: Data {
        Data()
    }
    
    public var task: Task {
        
        switch self {
        case .imagery(let data, let page):
            let params: [String: Any] = ["api_key" : ConfigurationManager.sharedInstance.serverKey ?? "",
                                         "bbox" : data.geometryString(),
                                         "satelites" : data.satellitesString(),
                                         "date_from" : data.dateFromString(),
                                         "page" : page]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .filesList(_):
            let params: [String: Any] = ["api_key" : ConfigurationManager.sharedInstance.serverKey ?? ""]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
