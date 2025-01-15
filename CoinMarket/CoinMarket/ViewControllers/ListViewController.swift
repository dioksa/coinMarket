//
//  ListViewController.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import UIKit

protocol ListViewDelegate: AnyObject {
    func updateTableView()
    func stopRefreshing()
}

final class ListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: LoadingView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private let refreshControl = UIRefreshControl()
    
    private var timer: Timer?
    
    var presenter: ListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List of Cryptocurrencies"
        view.backgroundColor = UIColor(named: "LightOrange")
        setupTableView()
        presenter?.loadList()
        configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector:#selector(currentTimeChanged) , userInfo: nil, repeats: true)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.registerCellClass(CurrencyListCell.self)
        loadingView.isHidden = false
        tableView.isHidden = true
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    // MARK: - Private actions
    @objc private func refresh(_ sender: AnyObject) {
        presenter?.loadList()
    }
    
    @objc private func currentTimeChanged() {
        presenter?.loadList()
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.searchResults?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCellOfType(CurrencyListCell.self),
              let items = presenter?.searchResults else {
            return UITableViewCell()
        }
        
        cell.setupCell(with: items[indexPath.row].name,
                       code: items[indexPath.row].symbol,
                       and: items[indexPath.row].quote.usd?.price ?? .zero)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openDetailsScreen(with: indexPath)
    }
}


// MARK: - ListViewDelegate
extension ListViewController: ListViewDelegate {
    func updateTableView() {
        tableView.reloadData()
        loadingView.isHidden = true
        tableView.isHidden = false
    }
    
    func stopRefreshing() {
        searchBar.text = nil
        refreshControl.endRefreshing()
    }
}


// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == .zero {
            presenter?.clearResults()
        }
        
        presenter?.showSearchResults(for: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.clearResults()
        searchBar.text = nil
        searchBar.endEditing(true)
    }
}
