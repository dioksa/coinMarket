//
//  URLRequest.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import UIKit

public enum APiVersion: String {
    case v1 = "/v1/"
}

enum HTTPMethod: String {
    case GET 
}

private let baseURL = "https://pro-api.coinmarketcap.com"

extension URLRequest {
    init(_ url: String, api: APiVersion = .v1, method: HTTPMethod = .GET) {
        let baseURL = URL(string: baseURL + api.rawValue)!
        let fullUrl = URL(string: url.encodeUrl, relativeTo: baseURL)!
        
        self.init(url: fullUrl)
        
        cachePolicy = .reloadRevalidatingCacheData
        httpMethod = method.rawValue
        
        // MARK: - Headers
        setValue("82f69f82-5456-458e-b79b-cd4e493bcc2d", forHTTPHeaderField: "X-CMC_PRO_API_KEY")

    }
}
