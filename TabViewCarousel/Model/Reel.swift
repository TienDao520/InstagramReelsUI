//
//  Reel.swift
//  TabViewCarousel
//
//  Created by Tien Dao on 2022-11-02.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {

    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}

