//
//  SnappingFlowLayout.swift
//  TikTakRush
//
//  Created by Thyago on 23/03/23.
//

import Foundation
import UIKit

final class SnappingFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        scrollDirection = .vertical
        minimumLineSpacing = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        let targetRect = CGRect(x: 0,
                                y: proposedContentOffset.y,
                                width: collectionView.frame.width,
                                height: collectionView.frame.height)
        let verticalCenter = proposedContentOffset.y + collectionView.frame.height / 2
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        
        guard let attributesList = super.layoutAttributesForElements(in: targetRect) else {
            return proposedContentOffset
        }
        
        for attributes in attributesList {
            if abs(attributes.center.y - verticalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = attributes.center.y - verticalCenter
            }
        }
        
        return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y + offsetAdjustment)
    }
    
    // Optional in case that we need to resize de cell on swipe
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let collectionView = collectionView,
              let attributesList = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        
        attributesList.forEach { attributes in
            let distance = visibleRect.midY - attributes.center.y
            let newScale = max(1 - abs(distance) * 0.001, 0.9)
            
            attributes.transform = .init(scaleX: newScale, y: newScale)
        }
        
        return attributesList
    }
}

