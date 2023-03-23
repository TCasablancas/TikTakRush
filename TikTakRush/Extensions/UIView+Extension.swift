//
//  UIView+Extension.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import Foundation
import UIKit

protocol ClosureConfigurable { }

extension ClosureConfigurable where Self: UIView {
    
    init(_ configure: (Self) -> Void) {
        self.init(frame: .zero)
        configure(self)
    }
    
    func applying(configuration configure: (Self) -> Void) -> Self {
        configure(self)
        return self
    }
    
}

extension UIView: ClosureConfigurable {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func instantiate(autolayout: Bool = true) -> Self {
        func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
            let view = self.nib.instantiate() as! T
            view.translatesAutoresizingMaskIntoConstraints = !autolayout
            return view
        }
        return instantiateUsingNib(autolayout: autolayout)
    }
    
    func resetOrigin() {
        frame.origin.y = 0
        frame.origin.x = 0
    }
    
    func setAutoresizingMaskIntoConstraintsForAllSubviews() {
        for v in self.subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func embed(subview: UIView, padding: UIEdgeInsets = .zero, ignore: [UIRectEdge] = []) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(subview)
        
        if ignore.contains(.all) {
            return
        }
        
        if ignore.contains(.top) == false {
            let constraint = subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                                          constant: padding.top)
            constraint.identifier = "topAnchor.constraint"
            constraint.isActive = true
        }
        
        if ignore.contains(.right) == false {
            let constraint = subview.rightAnchor.constraint(equalTo: rightAnchor,
                                                            constant: padding.right * -1.0)
            constraint.identifier = "rightAnchor.constraint"
            constraint.isActive = true
        }
        
        if ignore.contains(.bottom) == false {
            let constraint = subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                             constant: padding.bottom * -1.0)
            constraint.identifier = "bottomAnchor.constraint"
            constraint.isActive = true
        }
        
        if ignore.contains(.left) == false {
            let constraint = subview.leftAnchor.constraint(equalTo: leftAnchor,
                                                           constant: padding.left)
            constraint.identifier = "leftAnchor.constraint"
            constraint.isActive = true
        }
    }
}

extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
