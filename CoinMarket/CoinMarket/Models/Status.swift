//
//  Status.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 16.04.2022.
//

import Foundation

struct Status: Codable {
    let timestamp: String
    let errorCode: Int
    let elapsed: Int
    let creditCount: Int
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case errorCode = "error_code"
        case elapsed
        case creditCount = "credit_count"
    }
}
