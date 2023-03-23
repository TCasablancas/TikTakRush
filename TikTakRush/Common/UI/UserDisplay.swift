//
//  UserDisplay.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class UserDisplay: BaseView {
    
    //MARK: - UI
    
    private let mainStack = UIStackView() {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    private let textStack = UIStackView() {
        $0.axis = .vertical
    }
    
    private let userPicView = UIView() {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.red.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let userNameLabel = UILabel() {
        $0.text = "Thyago Casablancas"
        $0.font = UIFont.init(name: "Nunito-SemiBold", size: 13)
        $0.numberOfLines = .zero
    }
    
    private let followersLabel = UILabel() {
        $0.text = "1.280"
        $0.font = UIFont.init(name: "Nunito-Light", size: 12)
        $0.numberOfLines = .zero
    }
    
    // MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        addSubview(mainStack)
        mainStack.addArrangedSubviews(views: [userPicView, textStack])
        textStack.addArrangedSubviews(views: [userNameLabel, followersLabel])
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            mainStack.widthAnchor.constraint(equalTo: widthAnchor),
            
            userPicView.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
}
