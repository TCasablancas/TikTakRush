//
//  CounterButton.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class CounterButton: BaseView {
    
    var counter: Int = 0
    var imageIcon: String
    var isLike: Bool
    
    //MARK: - UI
    
    private let mainStack = UIStackView() {
        $0.spacing = 6
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let container = UIView()
    
    private lazy var iconButton = UIButton() {
        $0.setBackgroundImage(UIImage(named: imageIcon), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var counterLabel = UILabel() {
        $0.textColor = .white
        $0.text = "\(counter)"
        $0.font = UIFont.init(name: "Nunito-SemiBold", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Initialize
    
    required init(imageIcon: String, isLike: Bool) {
        self.imageIcon = imageIcon
        self.isLike = isLike
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required public init() {
        fatalError("init() has not been implemented")
    }
    
    override func initialize() {
        backgroundColor = .clear
        clipsToBounds = false
        
        addSubview(mainStack)
        container.addSubview(iconButton)
        
        if isLike {
            mainStack.addArrangedSubviews(views: [container, counterLabel])
            iconButton.addTarget(self, action: #selector(tapIncrease), for: .touchUpInside)
        } else {
            mainStack.addArrangedSubviews(views: [counterLabel, container])
            iconButton.addTarget(self, action: #selector(tapIncrease), for: .touchUpInside)
        }
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 40),
            container.heightAnchor.constraint(equalToConstant: 40),
            
            iconButton.widthAnchor.constraint(equalTo: container.widthAnchor),
            iconButton.heightAnchor.constraint(equalTo: container.heightAnchor)
        ])
    }
    
    @objc
    func tapIncrease() {
        sumAction()
    }
    
    @objc
    func tapIncreaseFire() {
        sumAction()
    }
    
    private func sumAction() {
        guard let presentValue = Int(counterLabel.text!) else {
            return
        }
        let newValue = presentValue + 1
        counterLabel.text = String(newValue)
    }
}
