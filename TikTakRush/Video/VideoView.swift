//
//  VideoView.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class VideoView: BaseView {
    
    //MARK: - UI
    
    private let topInfoView = TopInfo {
        $0.setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
    
    let likeButton = CounterButton {
        $0.setupButton(isLike: true)
    }
    
    private let fireButton = CounterButton {
        $0.setupButton(isLike: false)
    }
    
    //MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        addSubview(topInfoView)
        addSubview(likeButton)
        addSubview(fireButton)
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            topInfoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            topInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            fireButton.widthAnchor.constraint(equalToConstant: 30),
            fireButton.heightAnchor.constraint(equalToConstant: 30),
            fireButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            fireButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
}
