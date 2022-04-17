//
//  CurrencyListCell.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import UIKit

final class CurrencyListCell: UITableViewCell {
    @IBOutlet private weak var currencyTitleLabel: UILabel!
    @IBOutlet private weak var currencyCodeLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currencyTitleLabel.text = nil
        currencyCodeLabel.text = nil
        rateLabel.text = nil
    }
    
    func setupCell(with name: String,
                   code: String,
                   and price: Double) {
        currencyTitleLabel.text = name
        currencyCodeLabel.text = code
        
        let decimalUsdValue = NSDecimalNumber(value: price)
        rateLabel.text = "\(decimalUsdValue)"
    }
}
