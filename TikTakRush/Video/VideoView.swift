//
//  VideoView.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class VideoView: BaseView {
    
    // MARK: - Initialize
        
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([])
    }
    
    
}
