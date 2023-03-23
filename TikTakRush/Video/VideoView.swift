//
//  VideoView.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class VideoView: BaseView {
    
    //MARK: - UI
    
    private let containerView = UIView()
    
    private let topInfoView = TopInfo {
        $0.setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
    
    //MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        embed(subview: containerView, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        containerView.embed(subview: topInfoView)
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
    
    
}
