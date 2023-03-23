//
//  CacheVideo.swift
//  TikTakRush
//
//  Created by Thyago on 23/03/23.
//

import Foundation

public class MediaCache: NSObject {
    
    static let shared = MediaCache()
    
    let memoryCached = NSCache<NSString, NSData>()
    
    public func cacheItem(_ mediaItem: Data, forKey key: String) {
        memoryCached.setObject(mediaItem as NSData, forKey: key as NSString)
    }
    
    public func getItem(forKey key: String) -> Data? {
        return memoryCached.object(forKey: key as NSString) as Data?
    }
}
