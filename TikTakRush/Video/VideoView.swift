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
    
    //MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        addSubview(topInfoView)
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            topInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            topInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    
}
