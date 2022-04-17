//
//  NetworkManager.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import Foundation

enum Path: String {
    case listings = "cryptocurrency/listings/latest"
    case quotes = "cryptocurrency/quotes/latest"
}

protocol NetworkManagerProtocol {
    func getListResult(_ completion: @escaping ((Result<CurrencyDetailsModel, Error>) -> Void))
    func getCurrencyDetails(id: Int,
                            convertValue: String,
                            _ completion: @escaping ((Result<CurrencyObjectModel, Error>) -> Void))
}

final class NetworkManager: RequestExecution, NetworkManagerProtocol {
    func getListResult(_ completion: @escaping ((Result<CurrencyDetailsModel, Error>) -> Void)) {
        let request = URLRequest(Path.listings.rawValue)
        execute(request, completion: completion)
    }
    
    func getCurrencyDetails(id: Int,
                            convertValue: String,
                            _ completion: @escaping ((Result<CurrencyObjectModel, Error>) -> Void)) {
        let request = URLRequest(Path.quotes.rawValue + "?id=\(id)&convert=\(convertValue)")
        execute(request, completion: completion)
    }
}
