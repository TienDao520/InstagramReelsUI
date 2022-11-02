//
//  ReelsView.swift
//  TabViewCarousel
//
//  Created by Tien Dao on 2022-11-02.
//

import SwiftUI
import AVFoundation

struct ReelsView: View {
    
    @State var currentReel = ""
    // Extracting AVPlayer from media Files
    @State var reels = MediaFileJson.map { item -> Reel in
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        return Reel(player:player,mediaFile: item)

    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
    }
}
