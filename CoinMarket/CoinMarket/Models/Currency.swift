//
//  Currency.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 18.04.2022.
//

import Foundation

struct Currency: Codable {
    var price: Double
    let percentChange1H, percentChange24H, percentChange7D: Double
    let marketCap: Double

    enum CodingKeys: String, CodingKey {
        case price
        case percentChange1H = "percent_change_1h"
        case percentChange24H = "percent_change_24h"
        case percentChange7D = "percent_change_7d"
        case marketCap = "market_cap"
    }
}
