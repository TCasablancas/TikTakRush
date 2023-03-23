//
//  VideoView.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class VideoView: BaseView {
    
    //MARK: - UI
    
    private let userView = UserDisplay {
        $0.setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
    
    //MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        addSubview(userView)
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            userView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            userView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    
}
