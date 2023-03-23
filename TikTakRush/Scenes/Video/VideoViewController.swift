//
//  VideoViewController.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import Foundation
import UIKit
import AVFoundation

final class VideoViewController: BaseViewController<VideoView> {
    
    //MARK: - Properties
    
    private let reuseIdentifier = "collectionViewCell"
    private let viewModel: VideoViewModel
    private var videos: [VideoModel] = []
    
    init(viewModel: VideoViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectioView()
        viewModel.delegate = self
        viewModel.fetchDataFromJSON()
    }
}

extension VideoViewController: VideoViewModelDelegate {
    func setupVideoData(videoArr: [VideoModel]) {
        videos = videoArr
        baseView.collectionView.reloadData()
    }
}

private extension VideoViewController {
    func setupCollectioView() {
        baseView.collectionView.delegate = self
        baseView.collectionView.dataSource = self
        baseView.collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        baseView.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
//    @objc
//    func scrollToNextCell() {
//        let height = self.view.frame.height
//        let cellSize = CGSizeMake(self.view.frame.width, height)
//        let contentOffset = baseView.collectionView.contentOffset
//        UIView.animate(withDuration: 1.0,
//                       delay: 0.2,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: .curveEaseInOut,
//                       animations: {
//            self.baseView.collectionView.scrollRectToVisible(CGRectMake(contentOffset.x,
//                                                                   contentOffset.y + cellSize.height,
//                                                                   cellSize.width,
//                                                                   cellSize.height),
//                                                        animated: true)
//        })
//
//    }
//
//    func startTimer() {
//        let timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                         target: self,
//                                         selector: #selector(scrollToNextCell),
//                                         userInfo: nil,
//                                         repeats: true)
//    }
}

extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCollectionViewCell
        let item = videos[indexPath.row]
        
        cell.configureWith(with: item)
        cell.setAutoresizingMaskIntoConstraintsForAllSubviews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("@! >>> Collection view at row \(collectionView.tag); selected index path \(indexPath)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageFloat = (scrollView.contentOffset.y / scrollView.frame.size.height)
        let pageInt = Int(round(pageFloat))

        switch pageInt {
        case 0:
            baseView.collectionView.scrollToItem(at: [0, 3], at: .centeredVertically, animated: true)
        case videos.count - 1:
            baseView.collectionView.scrollToItem(at: [0, 1], at: .centeredVertically, animated: false)
        default:
            break
        }
    }
}

extension VideoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        if let cellRect = (collectionView.layoutAttributesForItem(at: indexPath)?.frame) {
//            let completelyVisible = collectionView.bounds.contains(cellRect)
//            if completelyVisible {
//                cell.playVideo()
//                print("@! >>> Cell is visible!")
//            }
//        }
        
        return CGSize(width: collectionView.bounds.width, height: UIScreen.main.bounds.height)
    }
}



//    func setupBackgroundVideo() {
//        guard let path = Bundle.main.path(forResource: "compressed_for_ios_url", ofType: "mp4") else {
//            return
//        }
//
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.bounds
//        playerLayer.videoGravity = .resizeAspectFill
//
//        player.play()
//    }
