//
//  Reel.swift
//  ScrollAndTabView
//
//  Created by Tien Dao on 2022-11-03.
//

import SwiftUI
import AVKit

struct Step: Identifiable {

    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
