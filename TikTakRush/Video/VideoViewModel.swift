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
        service.parseFromJSON { (result) in
            switch result {
            case .success(let model):
                print(model.looks.map({ $0.title }))
            case .serverError(let error):
                let errorData = "\(error.statusCode), -, \(error.msgError)"
                print("Server error: \(errorData) \n")
            case .timeOut(let description):
                print("Server error noConnection: \(description) \n")
            case .noConnection(let description):
                print("Server error timeOut: \(description) \n")
            }
        }
    }
}
