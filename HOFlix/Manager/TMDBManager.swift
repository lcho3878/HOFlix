//
//  TMDBManager.swift
//  HOFlix
//
//  Created by 이찬호 on 6/24/24.
//

import Foundation
import Alamofire

final class TMDBManager {
    
    static let shared = TMDBManager()
    
    private init () {}
    
    func callMovieRequest<T: Decodable>(api: TMDBRequest, type: T.Type, completionHandler: @escaping (T) -> Void) {
        guard let url = api.endpoint else { return }
        AF.request(url,
                   method: api.method,
                   parameters: api.paramters,
                   headers: api.header)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
