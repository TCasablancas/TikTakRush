//
//  CounterButton.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class CounterButton: BaseView {
    
    var increaseDidTap: (() -> Void)?
    var counter: Int = 0
    
    //MARK: - UI
    
    private let mainStack = UIStackView() {
        $0.spacing = 6
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var likeIconButton = UIButton() {
        $0.setBackgroundImage(UIImage(named: "heart-icon"), for: .normal)
        $0.addTarget(self, action: #selector(tapIncrease), for: .touchUpInside)
    }
    
    private lazy var fireIconButton = UIButton() {
        $0.setBackgroundImage(UIImage(named: "fire-icon"), for: .normal)
        $0.addTarget(self, action: #selector(tapIncrease), for: .touchUpInside)
    }
    
    private lazy var counterLabel = UILabel() {
        $0.text = "\(counter)"
        $0.font = UIFont.init(name: "Nunito-SemiBold", size: 16)
    }
    
    //MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        addSubview(mainStack)
        mainStack.addArrangedSubviews(views: [likeIconButton, counterLabel, fireIconButton])
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            likeIconButton.widthAnchor.constraint(equalToConstant: 40),
            likeIconButton.heightAnchor.constraint(equalToConstant: 40),
            fireIconButton.widthAnchor.constraint(equalToConstant: 40),
            fireIconButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    public func setupButton(isLike: Bool) {
        if isLike {
            fireIconButton.isHidden = isLike
        } else {
            likeIconButton.isHidden = !isLike
        }
    }
    
    @objc
    func tapIncrease() {
        self.increaseDidTap?()
    }
}
