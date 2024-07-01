//
//  VideoResult.swift
//  HOFlix
//
//  Created by 이찬호 on 7/1/24.
//

import Foundation

struct VideoResult: Decodable {
    let id: Int
    let results: [Video]
    
    struct Video: Decodable {
        let iso_639_1: String
        let iso_3166_1: String
        let name: String
        let key: String
        let site: String
        let size: Int
        let type: String
        let official: Bool
        let published_at: String
        let id: String
    }
}


