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
    case search(query: String, page: Int)
    
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
        case .search:
            return URL(string: baseURL + "search/movie")
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
        switch self {
        case .search(let query, let page):
            return [
                "language": "ko-KR",
                "query": query,
                "page": page
            ]
        default:
            return [
                "language": "ko-KR"
            ]
        }
    }
    
}
