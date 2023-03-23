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
}

extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
