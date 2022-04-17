//
//  CurrencyDetailsModel.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 16.04.2022.
//

import Foundation

struct CurrencyDetailsModel: Codable {
    let status: Status
    let data: [CurrencyDetails]
}
