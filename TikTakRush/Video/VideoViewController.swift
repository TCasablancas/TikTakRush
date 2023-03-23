//
//  VideoViewController.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import Foundation
import UIKit

final class VideoViewController: BaseViewController<VideoView> {
    
    //MARK: - Properties
    
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
}
