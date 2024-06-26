//
//  TMDBRequest.swift
//  HOFlix
//
//  Created by 이찬호 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBRequest {
    
    case trending
    case credits(movieID: Int)
    case recommendations(movieID: Int)
    case similar(movieID: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL? {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/movie/day")
        case .credits(let movieID):
            return URL(string: baseURL + "/movie/\(movieID)/credits")
        case .recommendations(let movieID):
            return URL(string: baseURL + "/movie/\(movieID)/recommendations")
        case .similar(let movieID):
            return URL(string: baseURL + "/movie/\(movieID)/similar")
        }
    }
    
    var header: HTTPHeaders {
        return [
            "Authorization": APIKey.tmdbToken,
            "accept": "application/json"
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var paramters: Parameters {
        return [
            "language": "ko-KR"
        ]
    }
    
}
