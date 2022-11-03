//
//  MediaFile.swift
//  ScrollAndTabView
//
//  Created by Tien Dao on 2022-11-03.
//

import SwiftUI

// Structure of stored Media
struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
    
}

var MediaFileJson = [
    MediaFile(url: "Reel1", title: "Reel 1 title"),
    MediaFile(url: "Reel2", title: "Reel 2 title"),
    MediaFile(url: "Reel3", title: "Reel 3 title"),
    MediaFile(url: "Reel4", title: "Reel 4 title"),
    MediaFile(url: "Reel5", title: "Reel 5 title"),
    MediaFile(url: "Reel6", title: "Reel 6 title"),
]

var MediaFileJsonSum = [
    MediaFileJson, MediaFileJson, MediaFileJson, MediaFileJson
]


