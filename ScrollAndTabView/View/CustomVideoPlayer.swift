//
//  CustomVideoPlayer.swift
//  ScrollAndTabView
//
//  Created by Tien Dao on 2022-11-03.
//

import SwiftUI
import AVKit

// Custom Video Player from UIKit
struct CustomVideoPlayer: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        controller.player = player
        controller.showsPlaybackControls = false
        
//        controller.videoGravity = .resizeAspectFill
        controller.view.isUserInteractionEnabled = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }

}
