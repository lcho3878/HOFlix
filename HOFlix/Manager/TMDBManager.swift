//
//  TMDBManager.swift
//  HOFlix
//
//  Created by 이찬호 on 6/24/24.
//

import Foundation
import Alamofire

class TMDBManager {
    
    static let shared = TMDBManager()
    
    private init () {}
    
    func callTrendRequest(completionHandler: @escaping (MovieResult) -> Void) {
        let url = URL.trending.rawValue
        let headers = HTTPHeaders([
            APIHeaders.Authorization.rawValue: APIHeaders.Authorization.value,
            APIHeaders.accept.rawValue: APIHeaders.accept.value
        ])
        let param: Parameters = [
            APIParameters.language.rawValue: APIParameters.language.value
        ]
        AF.request(url, parameters: param, headers: headers).responseDecodable(of: MovieResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callCastRequest(_ id: Int, completionHander: @escaping (CastResult) -> Void) {
        let url = URL.credits.rawValue + String(id) + "/credits"
        let params: Parameters = [
            APIParameters.language.rawValue : APIParameters.language.value
        ]
        let headers: HTTPHeaders = [
            APIHeaders.Authorization.rawValue: APIHeaders.Authorization.value,
            APIHeaders.accept.rawValue: APIHeaders.accept.value
        ]
        AF.request(url, parameters: params, headers: headers)
            .responseDecodable(of: CastResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHander(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    enum URL: String {
        case trending = "https://api.themoviedb.org/3/trending/movie/day"
        case credits = "https://api.themoviedb.org/3/movie/"
    }
    
    enum APIParameters: String {
        case language
        var value: String {
            switch self {
            case .language:
                return "ko-KR"
            }
        }
    }
    
    enum APIHeaders: String {
        case Authorization
        case accept
        var value: String {
            switch self {
            case .Authorization:
                return APIKey.tmdbToken
            case .accept:
                return "application/json"
            }
        }
    }
}
