//
//  VideoView.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import UIKit

final class VideoView: BaseView {
    
    //MARK: - UI
    
    private let flowlayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        return flow
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: flowlayout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.alwaysBounceVertical = true
        return collection
    }()
    
    //MARK: - Initialize
    
    override func initialize() {
        backgroundColor = .white
        clipsToBounds = false
        
        addSubview(collectionView)
        sendSubviewToBack(collectionView)
    }
    
    override func installConstraints() {
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
