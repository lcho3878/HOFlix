//
//  Movie.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import Foundation

struct MovieResult: Decodable {
    let page: Int
    let total_pages: Int
    let total_results: Int
    let results: [MovieInfo]
}

struct MovieInfo: Decodable{
    let backdrop_path: String
    let id: Int
    let original_title: String
    let overview: String
    let poster_path: String
    let media_type: String
    let adult: Bool
    let title: String
    let original_language: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
