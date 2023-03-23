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
    
    var counter: Int = 0
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.setAutoresizingMaskIntoConstraintsForAllSubviews()
        
        baseView.likeButton.counter = counter
        
        baseView.likeButton.increaseDidTap = {
            print(self.counter += 1)
        }
    }
}
