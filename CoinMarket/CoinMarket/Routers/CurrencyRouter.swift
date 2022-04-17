//
//  CurrencyRouter.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import UIKit

final class CurrencyRouter: RouterProtocol {
    private var navigationController: UINavigationController?
    
    required init(_ navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushDetailsController(_ currency: CurrencyDetails) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "detailsViewController") as? DetailsViewController else { return }
        controller.presenter = DetailsPresenter(currency)
        navigationController?.pushViewController(controller, animated: true)
    }
}
