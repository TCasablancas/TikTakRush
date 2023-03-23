//
//  TopInfo.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class TopInfo: BaseView {
    
    //MARK: - UI
    
    private let mainStack = UIStackView(axis: .vertical, spacing: 10)
    
    private let titleLabel = UILabel() {
        $0.text = "Texto Aleatório do Vídeo"
        $0.font = UIFont.init(name: "Nunito-SemiBold", size: 20)
    }
    
    private let userView = UserDisplay {
        $0.setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
    
    //MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        addSubview(mainStack)
        mainStack.addArrangedSubviews(views: [titleLabel, userView])
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            userView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
