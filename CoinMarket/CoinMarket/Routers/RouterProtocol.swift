//
//  RouterProtocol.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import UIKit

protocol RouterProtocol {
    init(_ navigationController: UINavigationController?)
    
    func push(_ viewController: UIViewController)
}
