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
    let backdrop_path: String?
    let id: Int
    let original_title: String
    let overview: String
    let poster_path: String?
    let media_type: String?
    let adult: Bool
    let title: String
    let original_language: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
    var genres: String {
        var genres: [String] = []
        for item in genre_ids {
            switch item {
            case 28:
                genres.append("#Action")
            case 12:
                genres.append("#Adventure")
            case 16:
                genres.append("#Animation")
            case 35:
                genres.append("#Comedy")
            case 80:
                genres.append("#Crime")
            case 99:
                genres.append("#Documentary")
            case 18:
                genres.append("#Drama")
            case 10751:
                genres.append("#Family")
            case 14:
                genres.append("#Fantasy")
            case 36:
                genres.append("#History")
            case 27:
                genres.append("#Horror")
            case 10402:
                genres.append("#Music")
            case 9648:
                genres.append("#Mystery")
            case 10749:
                genres.append("#Romance")
            case 878:
                genres.append("#Science Fiction")
            case 10770:
                genres.append("#TV Movie")
            case 53:
                genres.append("#Thriller")
            case 10752:
                genres.append("#War")
            case 37:
                genres.append("#Western")
            default: break
            }
        }
        return genres.joined(separator: " ")
    }
    
    var posterImageURL: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w400" + (poster_path ?? "")) else { return nil }
        return url
    }
    
    var backImageURL: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w400" + (backdrop_path ?? "")) else { return nil }
        return url
    }
}

