//
//  CurrencyDetails.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 18.04.2022.
//

import Foundation

struct CurrencyDetails: Codable {
    let id: Int
    let name, symbol: String
    let maxSupply: Int?
    let totalSupply: Double
    var quote: Quote

    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case maxSupply = "max_supply"
        case totalSupply = "total_supply"
        case quote
    }
}
