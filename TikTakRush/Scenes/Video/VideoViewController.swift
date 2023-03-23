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
    
    let stackLayout = SnappingFlowLayout()
    
    private let reuseIdentifier = "collectionViewCell"
    private let viewModel: VideoViewModel
    private var videos: [VideoModel] = []
    
    private var audioPlayer: AVPlayer?
    private var audioPlayerLayer: AVPlayerLayer?
    private var audioLooper: NSObject?
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
        playerLayer.frame = CGRect (x:-50,
                                    y:-90,
                                    width: UIScreen.main.bounds.width + 160,
                                    height: UIScreen.main.bounds.height + 160)
        cell.playerView.layer.addSublayer(playerLayer)
        videoPlayer?.play()
    }
    
    func getAudioPlayer(from item: VideoModel) {
        
        guard let url = URL(string: item.song) else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            let playerItem = AVPlayerItem(url: url)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.audioPlayer = AVQueuePlayer(items: [playerItem])
                self.audioLooper = AVPlayerLooper(player: self.audioPlayer! as! AVQueuePlayer,
                                             templateItem: playerItem)
                self.audioPlayer?.play()
            }
        } catch {
            debugPrint("an error was encoutered while trying to pick up song: \(error)")
        }
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
        getAudioPlayer(from: item)
        cell.configureWith(with: item)
        cell.setAutoresizingMaskIntoConstraintsForAllSubviews()
        
        cell.swipeAction = {
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        print("@! >>> Adicionado 1 like")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("@! >>> Collection view at row \(collectionView.tag); selected index path \(indexPath)")
    }
}

extension VideoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: UIScreen.main.bounds.height)
    }
}
