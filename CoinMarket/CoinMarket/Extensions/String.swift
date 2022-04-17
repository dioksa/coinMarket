//
//  String.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 18.04.2022.
//

import Foundation

extension String {
    var encodeUrl : String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
}
