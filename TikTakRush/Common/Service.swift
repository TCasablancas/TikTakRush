//
//  Service.swift
//  TikTakRush
//
//  Created by Thyago on 23/03/23.
//

import Foundation

protocol ServiceProtocol {
    func parseFromJSON(completion: @escaping ((Response<LooksModel>) -> Void))
}

struct Service: ServiceProtocol {
    
    func parseFromJSON(completion: @escaping ((Response<LooksModel>) -> Void)) {
        
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "MockData", ofType: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let result = try decoder.decode(LooksModel.self, from: data)
            
            completion(.success(model: result))
        } catch {
            print("error: \(error)")
        }
    }
}
