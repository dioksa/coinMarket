//
//  TableView.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import UIKit

extension UITableView {
    public func registerCellClass<T: UITableViewCell>(_ type: T.Type) {
        register(UINib.loadNib(with: String(describing: type)), forCellReuseIdentifier: String(describing: type))
    }
    
    public func dequeueCellOfType<T: UITableViewCell>(_ type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: type)) as? T
    }
}
