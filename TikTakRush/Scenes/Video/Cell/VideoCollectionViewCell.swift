//
//  VideoCollectionViewCell.swift
//  TikTakRush
//
//  Created by Thyago on 23/03/23.
//

import Foundation
import UIKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    //MARK: - Properties
    
    private var video: VideoModel?
    private var panGesture: UIPanGestureRecognizer!
    
    //MARK: - UI
    
    private let mainContainer = UIView() {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var playerView = PlayerView() {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let topInfoView = TopInfo {
        $0.setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
    
    private let likeSwipe = UIView()
    private let fireSwipe = UIView() {
        $0.backgroundColor = .red
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let likeButton = CounterButton(imageIcon: "heart-icon", isLike: true)
    private let fireButton = CounterButton(imageIcon: "fire-icon", isLike: false)
    
    //MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Cell Configuration

extension VideoCollectionViewCell {
    public func configureWith(with video: VideoModel) {
        self.video = video
        
        DispatchQueue.main.async {
            self.topInfoView.titleLabel.text = video.title
            self.topInfoView.userView.setupUserView(userImage: video.userPic, username: video.userName)
        }
    }
}

//MARK: - Setup View

extension VideoCollectionViewCell {
    func setup() {
        clipsToBounds = false
        
        addSubview(topInfoView)
        addSubview(likeButton)
        addSubview(fireButton)
        addSubview(playerView)
        sendSubviewToBack(playerView)
        
        NSLayoutConstraint.activate([
            playerView.widthAnchor.constraint(equalTo: widthAnchor),
            playerView.heightAnchor.constraint(equalTo: heightAnchor),
            
            topInfoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            topInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            likeButton.widthAnchor.constraint(equalToConstant: 50),
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            fireButton.widthAnchor.constraint(equalToConstant: 50),
            fireButton.heightAnchor.constraint(equalToConstant: 40),
            fireButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            fireButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
}
