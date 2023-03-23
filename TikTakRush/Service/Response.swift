//
//  Response.swift
//  TikTakRush
//
//  Created by Thyago on 23/03/23.
//

import Foundation

enum Response<T> {
    case success(model: T)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
}
