//
//  DetailsPresenter.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 16.04.2022.
//

import Foundation

protocol DetailsPresenterProtocol {
    init(_ currency: CurrencyDetails)
    
    var currency: CurrencyDetails { get }
}

final class DetailsPresenter: DetailsPresenterProtocol {
    var currency: CurrencyDetails
    
    init(_ currency: CurrencyDetails) {
        self.currency = currency
    }
}
