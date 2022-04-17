//
//  ViewController.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var animButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimButton()
    }
    
    // MARK: - Private methods
    private func setupAnimButton() {
        animButton.layer.cornerRadius = 12.0
        
        UIView.animate(withDuration: 0.8,
                       delay: 1.0,
                       options: .curveEaseInOut,
                       animations: {
            self.animButton.center.x += 500
            self.animButton.frame.size.width = 200
        }, completion: { _ in
            self.animButton.backgroundColor = UIColor(named: "LightRed")
        })
    }

    // MARK: - Private actions
    @IBAction private func animButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "listViewController") as? ListViewController else { return }
        controller.presenter = ListPresenter(CurrencyRouter(navigationController), controller)
        navigationController?.pushViewController(controller, animated: true)
    }
}

