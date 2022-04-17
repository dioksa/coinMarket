//
//  Quote.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 18.04.2022.
//

import Foundation

struct Quote: Codable {
    let usd: Currency?
    var btc: Currency?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case btc = "BTC"
    }
}
