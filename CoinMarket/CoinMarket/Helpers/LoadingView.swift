//
//  LoadingView.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 16.04.2022.
//

import Foundation
import UIKit

final class LoadingView: UIView {
    
    @IBInspectable var animationMask: UIImage!
    @IBInspectable var backgroundMask: UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        let backgroundView = UIImageView(image: backgroundMask)
        backgroundView.frame = bounds
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(backgroundView)
        
        let loadingView = LoadingImages(loadMask: animationMask)
        loadingView.frame = bounds
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(loadingView)
    }
    
    init() {
        super.init(frame: .zero)
        fatalError("Not use at this moment")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fatalError("Not use at this moment")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

final class LoadingImages: UIView {
    private let maskLayer = CALayer()
    private let gradientLayer = CAGradientLayer()
    private let gradientAnimation = CABasicAnimation(keyPath: "locations")
    
    @IBInspectable var imgMask: UIImage! {
        didSet {
            setup(with: imgMask)
        }
    }
    
    // MARK: - Init
    init(loadMask: UIImage) {
        super.init(frame: .zero)
        setup(with: loadMask)
    }
    
    init() {
        super.init(frame: .zero)
        fatalError("Use: init(frame: CGRect, loadMask: UIImage)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fatalError("Use: init(frame: CGRect, loadMask: UIImage)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup
    private func setup(with loadMask: UIImage) {
        backgroundColor = .clear
        
        maskLayer.contents = loadMask.cgImage
        maskLayer.frame = bounds
        layer.mask = maskLayer

        gradientLayer.masksToBounds = false
        gradientLayer.colors = [UIColor(named: "Gray200")!.cgColor,
                                UIColor(named: "Gray250")!.cgColor,
                                UIColor(named: "Gray200")!.cgColor]
        gradientLayer.locations = [0.0, 0.0, 0.25]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
        
        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.75, 1.0, 1.0]
        gradientAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        gradientAnimation.repeatCount = .infinity
        gradientAnimation.duration = 1.7
        gradientLayer.add(gradientAnimation, forKey: gradientAnimation.keyPath)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if maskLayer.frame != bounds {
            maskLayer.frame = bounds
            gradientLayer.frame = CGRect(x: -bounds.width, y: -bounds.height, width: bounds.width*3, height: bounds.height*3)
        }
    }
}
