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

    private let viewModel: VideoViewModel
    
    init(viewModel: VideoViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseView()
        
        viewModel.fetchDataFromJSON()
    }
}

private extension VideoViewController {
    func setupBaseView() {
        baseView.setAutoresizingMaskIntoConstraintsForAllSubviews()
        
        baseView.likeButton.increaseDidTap = {
            print()
        }
    }
}
