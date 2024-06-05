//
//  MovieModel.swift
//  HOFlix
//
//  Created by 이찬호 on 6/5/24.
//

import Foundation

struct Movie: Decodable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}

struct BoxOffice: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [Movie]
}

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: BoxOffice
}
