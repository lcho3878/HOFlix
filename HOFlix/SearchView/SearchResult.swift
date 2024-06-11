//
//  SearchResult.swift
//  HOFlix
//
//  Created by 이찬호 on 6/11/24.
//

import Foundation

struct SearchResult: Decodable {
    let page: Int
    let results: [MovieInfo]
    let total_pages: Int
    let total_results: Int
}
