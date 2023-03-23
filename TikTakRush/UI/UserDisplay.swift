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
    
    private let textStack = UIStackView(axis: .vertical)
    
    private let followersStack = UIStackView(axis: .horizontal, spacing: 2)
    
    private let userPicView = UIImageView() {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.red.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let userNameLabel = UILabel() {
        $0.font = UIFont.init(name: "Nunito-SemiBold", size: 13)
        $0.numberOfLines = .zero
    }
    
    private let followersLabel = UILabel() {
        $0.text = "128k"
        $0.font = UIFont.init(name: "Nunito-Light", size: 12)
        $0.numberOfLines = .zero
    }
    
    private let followerIcon = UIImageView {
        $0.image = UIImage(named: "follower-icon")
        $0.contentMode = .scaleToFill
    }
    
    // MARK: - Initialize
    
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        addSubview(mainStack)
        mainStack.addArrangedSubviews(views: [userPicView, textStack])
        followersStack.addArrangedSubviews(views: [followerIcon, followersLabel])
        textStack.addArrangedSubviews(views: [userNameLabel, followersStack])
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            mainStack.widthAnchor.constraint(equalTo: widthAnchor),
            
            userPicView.widthAnchor.constraint(equalToConstant: 38),
            userPicView.heightAnchor.constraint(equalToConstant: 38),
            
            followerIcon.widthAnchor.constraint(equalToConstant: 20),
            followerIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupUserView(userImage: String, username: String) {
        guard let url = URL(string: userImage) else { return }
        
        UIImage.loadFrom(url: url) { image in
            self.userPicView.image = image
        }
        
        userNameLabel.text = username
    }
}
