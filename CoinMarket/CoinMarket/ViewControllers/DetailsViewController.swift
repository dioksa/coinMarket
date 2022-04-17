//
//  DetailsViewController.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 16.04.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var exchangeRateLabel: UILabel!
    @IBOutlet private weak var exchangeValueLabel: UILabel!
    @IBOutlet private weak var exchangeRateToBTCLabel: UILabel!
    @IBOutlet private weak var exchangeValueToBTCLabel: UILabel!
    @IBOutlet private weak var totalCoinsLabel: UILabel!
    @IBOutlet private weak var totalCoinsValueLabel: UILabel!
    @IBOutlet private weak var maxCoinsLabel: UILabel!
    @IBOutlet private weak var maxCoinsValueLabel: UILabel!
    @IBOutlet private weak var totalCapLabel: UILabel!
    @IBOutlet private weak var totalCapValueLabel: UILabel!
    @IBOutlet private weak var progressLabel: UILabel!
    
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var hourValueLabel: UILabel!
    @IBOutlet private weak var hourImageView: UIImageView!
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var dayValueLabel: UILabel!
    @IBOutlet private weak var dayImageView: UIImageView!
    
    @IBOutlet private weak var weekLabel: UILabel!
    @IBOutlet private weak var weekValueLabel: UILabel!
    @IBOutlet private weak var weekImageView: UIImageView!
    
    var presenter: DetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitles()
        setValues()
        setupCurrencyIndicator(presenter?.currency.quote.usd?.percentChange1H,
                               hourImageView)
        setupCurrencyIndicator(presenter?.currency.quote.usd?.percentChange24H,
                               dayImageView)
        setupCurrencyIndicator(presenter?.currency.quote.usd?.percentChange7D,
                               weekImageView)
    }
    
    // MARK: - Private methods
    private func setTitles() {
        title = "Details"
        
        exchangeRateLabel.text = "Exchange to USD"
        exchangeRateToBTCLabel.text = "Exchange to BTC"
        
        totalCoinsLabel.text = "Total coins available"
        maxCoinsLabel.text = "Max coins available"
        
        totalCapLabel.text = "Total market capitalization"
        
        progressLabel.text = "Percent change to last"
        hourLabel.text = "1h"
        dayLabel.text = "24h"
        weekLabel.text = "7 days"
        
        guard let presenter = presenter else {
            titleLabel.text = nil
            return
        }

        titleLabel.text = "Currency - \(presenter.currency.name)"
    }
    
    private func setValues() {
        exchangeValueLabel.text = "\(presenter?.currency.quote.usd?.price ?? .zero)"
        let decimalValue = NSDecimalNumber(value: presenter?.currency.quote.btc?.price ?? .zero)
        
        exchangeValueToBTCLabel.text = "\(decimalValue)"

        totalCoinsValueLabel.text = "\(presenter?.currency.totalSupply ?? .zero)"
        maxCoinsValueLabel.text = "\(presenter?.currency.maxSupply ?? .zero)"
        
        totalCapValueLabel.text = "\(presenter?.currency.quote.usd?.marketCap ?? .zero)"
        
        hourValueLabel.text = "\(presenter?.currency.quote.usd?.percentChange1H ?? .zero)"
        dayValueLabel.text = "\(presenter?.currency.quote.usd?.percentChange24H ?? .zero)"
        weekValueLabel.text = "\(presenter?.currency.quote.usd?.percentChange7D ?? .zero)"
    }
    
    private func setupCurrencyIndicator(_ value: Double?, _ view: UIImageView) {
        guard let value = value else {
            return
        }

        view.image = value > .zero ? UIImage(named: "icUp") : UIImage(named: "icDown")
    }
}
