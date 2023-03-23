//
//  VideoCollectionViewCell.swift
//  TikTakRush
//
//  Created by Thyago on 23/03/23.
//

import Foundation
import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var video: VideoModel?
    
    //MARK: - UI
    
    private let container = UIView() {
        $0.backgroundColor = .lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let topInfoView = TopInfo {
        $0.setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
    
    let likeButton = CounterButton {
        $0.setupButton(isLike: true)
    }
    
    private let fireButton = CounterButton {
        $0.setupButton(isLike: false)
    }
    
    //MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureWith(with video: VideoModel) {
        self.video = video
        
        DispatchQueue.main.async {
            self.topInfoView.titleLabel.text = video.title
            self.topInfoView.userView.setupUserView(userImage: video.userPic, username: video.userName)
        }
    }
}

extension VideoCollectionViewCell {
    func setup() {
        addSubview(topInfoView)
        addSubview(likeButton)
        addSubview(fireButton)
        addSubview(container)
        sendSubviewToBack(container)
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: widthAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor),
            
            topInfoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            topInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            fireButton.widthAnchor.constraint(equalToConstant: 30),
            fireButton.heightAnchor.constraint(equalToConstant: 30),
            fireButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            fireButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
}
