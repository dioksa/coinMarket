//
//  CurrencyObjectModel.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 18.04.2022.
//

import Foundation

struct CurrencyObjectModel: Codable {
    let status: Status
    let data: [String: CurrencyDetails]
}
