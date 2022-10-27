//
//  ReelsView.swift
//  InstagramReelsUI
//
//  Created by Tien Dao on 2022-10-27.
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
        // Setting Width and height for rotated View
        GeometryReader{proxy in
            let size = proxy.size
            ///Vertical Page Tab View
            TabView(selection: $currentReel){
                ForEach($reels){$reel in
                    ReelsPlayer(reel: $reel)
                    //setting width
                    .frame(width: size.width)
                    .padding()
                    //Rotating Content
                    .rotationEffect(.init(degrees: -90))
                    
                }
            }
            /// View Rotation
            .rotationEffect(.init(degrees: 90))
            /// Since view is rotated setting height as width
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            /// seting max width
            .frame(width: size.width)
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ReelsPlayer: View{
    
    @Binding var reel: Reel
    
    var body: some View {
        ZStack{
            
        }
    }
}
