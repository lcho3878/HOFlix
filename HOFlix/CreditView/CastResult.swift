//
//  CastResult.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import Foundation

struct CastResult: Decodable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Decodable {
    let adult: Bool
    let gender: Int
    let id: Int
    let known_for_department: String
    let name: String
    let original_name: String
    let popularity: Double
    let profile_path: String?
    let cast_id: Int
    let character: String
    let credit_id: String
    let order: Int
}
