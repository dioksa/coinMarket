//
//  NetworkHelper.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import Foundation

protocol NetworkHelperDelegate {
    init(_ manager: NetworkManagerProtocol)
    
    func fetchCurrencyList(_ completion: @escaping ((Result<CurrencyDetailsModel, Error>) -> Void))
    func fetchDetails(id: Int,
                      _ convertValue: String,
                      _ completion: @escaping ((Result<CurrencyObjectModel, Error>) -> Void))
}

final class NetworkHelper: NetworkHelperDelegate {
    private let manager: NetworkManagerProtocol
    
    init(_ manager: NetworkManagerProtocol) {
        self.manager = manager
    }
    
    func fetchCurrencyList(_ completion: @escaping ((Result<CurrencyDetailsModel, Error>) -> Void)) {
        manager.getListResult(completion)
    }
    
    func fetchDetails(id: Int,
                      _ convertValue: String,
                      _ completion: @escaping ((Result<CurrencyObjectModel, Error>) -> Void)) {
        manager.getCurrencyDetails(id: id, convertValue: convertValue, completion)
    }
}
