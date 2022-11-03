//
//  Journey.swift
//  ScrollAndTabView
//
//  Created by Tien Dao on 2022-11-03.
//

import SwiftUI
import AVKit

struct Journey: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFiles: [MediaFile]
}


