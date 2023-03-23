//
//  VideoViewController.swift
//  TikTakRush
//
//  Created by Thyago on 22/03/23.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

final class VideoViewController: BaseViewController<VideoView> {
    
    //MARK: - Properties
    
    private let reuseIdentifier = "collectionViewCell"
    private let viewModel: VideoViewModel
    private var videos: [VideoModel] = []
    
    private var audioPlayer: AVPlayer?
    private var videoPlayer: AVPlayer?
    private var videoPlayerLayer: AVPlayerLayer?
    private var playerLooper: NSObject?
    
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
    
    func getBackgroundVideo(from item: VideoModel, _ cell: VideoCollectionViewCell) {
        
        guard let url = URL(string: item.footage) else {
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        videoPlayer = AVQueuePlayer(items: [playerItem])
        playerLooper = AVPlayerLooper(player: videoPlayer! as! AVQueuePlayer,
                                      templateItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = CGRect (x:0,
                                    y:-80,
                                    width: UIScreen.main.bounds.width + 120,
                                    height: UIScreen.main.bounds.height + 120)
        cell.playerView.layer.addSublayer(playerLayer)
        videoPlayer?.play()
    }
    
    private func setupAudioContent(from item: VideoModel, _ cell: VideoCollectionViewCell) {

        guard let url = URL(string: item.song) else {
            return
        }
        
        audioPlayer = AVPlayer(url: url)

        let playerLayer = AVPlayerLayer(player: audioPlayer)
        cell.playerView.layer.addSublayer(playerLayer)
//            playerLayer.frame = self.frame

        audioPlayer?.play()
        audioPlayer?.volume = 1.0
    }
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
        
        getBackgroundVideo(from: item, cell)
        setupAudioContent(from: item, cell)
        cell.configureWith(with: item)
        cell.setAutoresizingMaskIntoConstraintsForAllSubviews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("@! >>> Collection view at row \(collectionView.tag); selected index path \(indexPath)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells = baseView.collectionView.indexPathsForVisibleItems.sorted { top, bottom -> Bool in
            return top.section < bottom.section || top.row < bottom.row
        }.compactMap { indexPath -> UICollectionViewCell? in
            return baseView.collectionView.cellForItem(at: indexPath)
        }
        
        let indexPaths = baseView.collectionView.indexPathsForVisibleItems.sorted()
        let cellCount = visibleCells.count
        
        guard let firstCell = visibleCells.first as? VideoCollectionViewCell,
              let firstIndex = indexPaths.first else {
            return
        }
        
        checkVisibilityOfCell(cell: firstCell, indexPath: firstIndex)
        if cellCount == 1 {
            return
        }
        
        guard let lastCell = visibleCells.last as? VideoCollectionViewCell,
              let lastIndex = indexPaths.last else {
            return
        }
        
        checkVisibilityOfCell(cell: lastCell, indexPath: lastIndex)
    }
    
    func checkVisibilityOfCell(cell: VideoCollectionViewCell, indexPath: IndexPath) {
        if let cellRect = (baseView.collectionView.layoutAttributesForItem(at: indexPath)?.frame) {
            let completelyVisible = baseView.collectionView.bounds.contains(cellRect)
            if completelyVisible {
                //TODO
            } else {
                //TODO
            }
        }
    }
}

extension VideoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: UIScreen.main.bounds.height)
    }
}


