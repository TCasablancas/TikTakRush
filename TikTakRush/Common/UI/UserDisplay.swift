//
//  UserDisplay.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class UserDisplay: BaseView {
    
    //MARK: - UI
    
    private let mainStack = UIStackView(axis: .horizontal, spacing: 10)
    
    private let textStack = UIStackView(axis: .vertical, spacing: 6)
    
    private let followersStack = UIStackView(axis: .horizontal, spacing: 2)
    
    private let userPicView = UIView() {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.red.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let userNameLabel = UILabel() {
        $0.text = "@tcasablancas"
        $0.font = UIFont.init(name: "Nunito-SemiBold", size: 13)
        $0.numberOfLines = .zero
    }
    
    private let followersLabel = UILabel() {
        $0.text = "128k"
        $0.font = UIFont.init(name: "Nunito-Light", size: 12)
        $0.numberOfLines = .zero
    }
    
    private let heartIcon = UIImageView {
        $0.image = UIImage(named: "heart-icon")
        $0.contentMode = .scaleToFill
    }
    
    // MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        addSubview(mainStack)
        mainStack.addArrangedSubviews(views: [userPicView, textStack])
        followersStack.addArrangedSubviews(views: [heartIcon, followersLabel])
        textStack.addArrangedSubviews(views: [userNameLabel, followersStack])
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            mainStack.widthAnchor.constraint(equalTo: widthAnchor),
            userPicView.widthAnchor.constraint(equalToConstant: 35),
            heartIcon.widthAnchor.constraint(equalToConstant: 10),
            heartIcon.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}
