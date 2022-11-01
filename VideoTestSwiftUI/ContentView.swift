//
//  ContentView.swift
//  VideoTestSwiftUI
//
//  Created by Tien Dao on 2022-11-01.
//

import SwiftUI
import AVFoundation

// Structure of stored Media
struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
    
}
let mediaFile = MediaFile(url: "Reel1", title: "Reel 1 title")
let url = Bundle.main.path(forResource: mediaFile.url, ofType: "mp4") ?? ""

struct ContentView: View {
    

    let player = AVPlayer(url: URL(fileURLWithPath: url))
    var body: some View {
        ZStack {
                CustomeVideoPlayer(player: player)
                GeometryReader { proxy -> Color in
                    player.play()
                    return Color.clear
                }
                
                // Control playing video based on offset
//                GeometryReader { proxy -> Color in
//                    let minY = proxy.frame(in: .global).minY
//                    let size = proxy.size
//
//                    DispatchQueue.main.async {
//                        if -minY < (size.height / 2) && minY < (size.height / 2){
//                            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//                            player.play()
//                        }
//                        else{
//                            player.pause()
//                        }
//                    }
//                    return Color.clear
//                }
            
            
                
        }
//        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

