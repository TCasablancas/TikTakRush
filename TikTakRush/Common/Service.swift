//
//  Service.swift
//  TikTakRush
//
//  Created by Thyago on 23/03/23.
//

import Foundation

struct Service {
    
    func parseFromJSON() {

        if let path = Bundle.main.path(forResource: "MockData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let result = jsonResult as? Dictionary<String, Any>,
                   let item = result["looks"] as? [Any] {
                    print(item)
                }
            } catch {
                
            }
        }
    }
}
