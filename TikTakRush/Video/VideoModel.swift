//
//  VideoModel.swift
//  TikTakRush
//
//  Created by Thyago on 23/03/23.
//

import UIKit

struct VideoModel: Codable {
    var id: Int
    var song: String
    var title: String
    var userPic: String
    var userName: String
    var footage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case song = "song_url"
        case title = "body"
        case userPic = "profile_picture_url"
        case userName = "username"
        case footage = "compressed_for_ios_url"
    }
}
