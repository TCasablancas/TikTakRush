//
//  UserDisplay.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class UserDisplay: BaseView {
    
    //MARK: - UI
    
    
    
    // MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([])
    }
}
