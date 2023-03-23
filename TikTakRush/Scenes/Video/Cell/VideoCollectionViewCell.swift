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
    
    var swipeAction: (() -> Void)?
    private var video: VideoModel?
    private var pan: UIPanGestureRecognizer!
    
    //MARK: - UI
    
    var playerView = PlayerView() {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let topInfoView = TopInfo {
        $0.setAutoresizingMaskIntoConstraintsForAllSubviews()
    }
    
    let likeSwipe = UIView() {
        $0.backgroundColor = .systemRed
        $0.layer.cornerRadius = 40
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let fireSwipe = UIView() {
        $0.backgroundColor = .systemYellow
        $0.layer.cornerRadius = 40
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let likeButton = CounterButton(imageIcon: "heart-icon", isLike: true)
    private let fireButton = CounterButton(imageIcon: "fire-icon", isLike: false)
    
    //MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupPanGesture()
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

extension VideoCollectionViewCell {
    
    func setupPanGesture() {
        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (pan.state == UIGestureRecognizer.State.changed) {
            let p: CGPoint = pan.translation(in: self)
            let width = self.contentView.frame.width
            let height = self.contentView.frame.height
            self.contentView.frame = CGRect(x: p.x,
                                            y: 0,
                                            width: width,
                                            height: height);
            self.likeSwipe.frame = CGRect(x: p.x - width - likeSwipe.frame.size.width,
                                             y: frame.size.height / 2,
                                             width: 400,
                                             height: 80)
            self.fireSwipe.frame = CGRect(x: p.x + width + fireSwipe.frame.size.width,
                                          y: frame.size.height / 2,
                                          width: 400,
                                          height: 80)
        }
    }
    
    @objc
    func onPan(_ pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            break
        case .changed:
            self.setNeedsLayout()
        case .ended:
            onPanRegister()
        case .cancelled, .failed, .possible:
            break
        @unknown default:
            break
        }
    }
    
    func onPanRegister() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self,
                                                       action: #selector(swipeDetected))
        self.addGestureRecognizer(swipeRecognizer)
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else {
                return
            }
            
            if abs(self.pan.translation(in: self).x) > 120 {
                switch swipeRecognizer.direction {
                case .left:
                    self.fireButton.tapIncrease()
                case .right:
                    self.likeButton.tapIncrease()
                case .up, .down:
                    break
                default:
                    break
                }
            }
            
            self.contentView.isHidden = true
            self.setNeedsLayout()
            self.layoutIfNeeded()
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
    }
    
    @objc
    func swipeDetected() { }
}

//MARK: - Setup View

extension VideoCollectionViewCell {
    func setup() {
        clipsToBounds = false
        
        addSubview(topInfoView)
        addSubview(likeButton)
        addSubview(fireButton)
        addSubview(likeSwipe)
        addSubview(fireSwipe)
        addSubview(playerView)
        sendSubviewToBack(playerView)
        bringSubviewToFront(topInfoView)
        bringSubviewToFront(likeButton)
        bringSubviewToFront(fireButton)
        
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
            fireButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            likeSwipe.widthAnchor.constraint(equalToConstant: 80),
            likeSwipe.heightAnchor.constraint(equalToConstant: 80),
            likeSwipe.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -100),
            likeSwipe.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            
            fireSwipe.widthAnchor.constraint(equalToConstant: 80),
            fireSwipe.heightAnchor.constraint(equalToConstant: 80),
            fireSwipe.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 100),
            fireSwipe.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20)
        ])
    }
}
