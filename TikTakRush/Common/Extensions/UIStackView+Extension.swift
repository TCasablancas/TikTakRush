//
//  UIStackView+Extension.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

public extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        views.forEach { self.addArrangedSubview( $0 ) }
    }
}

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat = 0.0,
                     distribution: UIStackView.Distribution = .fill,
                     alignment: UIStackView.Alignment = .fill) {
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        self.setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
    
    func removeAllArrangedSubviews() {
        for (index, _) in arrangedSubviews.enumerated().reversed() {
            arrangedSubviews[index].removeFromSuperview()
        }
    }
}

