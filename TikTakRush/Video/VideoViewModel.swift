//
//  VideoViewModel.swift
//  TikTakRush
//
//  Created by Thyago on 23/03/23.
//

import Foundation
import UIKit

protocol VideoViewModelProtocol {
    func fetchDataFromJSON()
}

final class VideoViewModel: VideoViewModelProtocol {
    
    private var service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    func fetchDataFromJSON() {
        service.parseFromJSON()
    }
}
