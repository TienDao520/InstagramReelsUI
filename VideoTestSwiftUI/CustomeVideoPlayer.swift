//
//  CustomeVideoPlayer.swift
//  VideoTestSwiftUI
//
//  Created by Tien Dao on 2022-11-01.
//

import SwiftUI
import AVKit

// Custom Video Player from UIKit
struct CustomeVideoPlayer: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        controller.player = player
        controller.showsPlaybackControls = false
        
//        controller.videoGravity = .resizeAspectFill
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }


    
    
}

