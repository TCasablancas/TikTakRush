//
//  BaseViewController.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import Foundation
import UIKit

open class BaseViewController<View: BaseView>: UIViewController {
    
    //MARK: - Internal Variables
    
    public var baseView: View {
        return view as! View
    }
    
    //MARK: - Initializers
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    //MARK: - Override Methods
    
    override public func loadView() {
        view = View()
    }
}
