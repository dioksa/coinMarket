//
//  ListPresenter.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import Foundation

protocol ListPresenterProtocol {
    init(_ router: CurrencyRouter, _ delegate: ListViewDelegate)
    
    var searchResults: [CurrencyDetails]? { get }
    
    func loadList()
    func showSearchResults(for word: String)
    func openDetailsScreen(with indexPath: IndexPath)
    func clearResults()
}

final class ListPresenter: ListPresenterProtocol {
    private let router: CurrencyRouter
    private let delegate: ListViewDelegate
    
    private var data: [CurrencyDetails]? {
        didSet {
            searchResults = data
        }
    }
    
    var searchResults: [CurrencyDetails]?
    
    private var networkHelper = NetworkHelper(NetworkManager())
    
    init(_ router: CurrencyRouter, _ delegate: ListViewDelegate) {
        self.router = router
        self.delegate = delegate
    }
    
    func loadList() {
        networkHelper.fetchCurrencyList { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let model):
                self.data = model.data
                self.delegate.updateTableView()
                self.delegate.stopRefreshing()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func openDetailsScreen(with indexPath: IndexPath) {
        guard let results = searchResults else { return }
        var currentResult = results[indexPath.row]

        networkHelper.fetchDetails(id: currentResult.id, "BTC") { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let model):
                currentResult.quote.btc = model.data.first?.value.quote.btc
                self.router.pushDetailsController(currentResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showSearchResults(for word: String) {
        searchResults = []
        
        data?.forEach { currency in
            if currency.name.contains(word) || currency.symbol.contains(word) {
                searchResults?.append(currency)
                print(currency)
            }
        }
        
        delegate.updateTableView()
    }
    
    func clearResults() {
        searchResults = data
        delegate.updateTableView()
    }
}
