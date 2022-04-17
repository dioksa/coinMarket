//
//  UINib.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import UIKit

extension UINib {
    static func loadNib(with name: String) -> UINib {
        return UINib(nibName: name, bundle: nil)
    }
}
