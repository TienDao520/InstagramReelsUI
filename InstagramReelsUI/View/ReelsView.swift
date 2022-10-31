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
            Spacer()
            
            ///Vertical Page Tab View
            TabView(selection: $currentReel){
                ForEach($reels){$reel in
                    ReelsPlayer(reel: $reel)
                    //setting width
                    .frame(width: size.width)
                    .padding()
                    //Rotating Content
                    .rotationEffect(.init(degrees: -90))
                    .ignoresSafeArea(.all, edges: .top)
                }
            }
            /// View Rotation
            .rotationEffect(.init(degrees: 90))
            /// Since view is rotated setting height as width
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            /// seting max width
            .frame(width: size.width)
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ReelsPlayer: View{
    
    @Binding var reel: Reel
    
    //Expanding title when it is tapped
    @State var showMore = false
    
    var body: some View {
        VStack{
            // Check nil value
            if let player = reel.player{
//                UserInfo(reel: reel)
                CustomVideoPlayer(player: player)
                
//                VStack{
//                    HStack(alignment: .bottom) {
//
//                        VStack(alignment: .leading, spacing: 10) {
//                            HStack(spacing: 15) {
//                                Image("profile")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 35, height: 35)
//                                    .clipShape(Circle())
//                                Text("Tien Dao")
//                                    .font(.callout.bold())
//
//                                Button {
//
//                                } label: {
//                                    Text("Follow")
//                                        .font(.caption.bold())
//                                }
//
//                            }
//
//                            //Title  Custom View...
//                            ZStack{
//                                if showMore{
//
//                                    ScrollView(.vertical, showsIndicators: false) {
//
//                                        // Added extra text
//                                        Text(reel.mediaFile.title + sampleText)
//                                            .font(.callout)
//                                            .fontWeight(.semibold)
////                                            .lineLimit(1)
//                                    }
//                                    .frame(height: 120)
//                                }
//                                else{
//
//                                    Button {
//
//                                        withAnimation{showMore.toggle()}
//
//                                    } label: {
//                                        HStack{
//
//                                            Text(reel.mediaFile.title)
//                                                .font(.callout)
//                                                .fontWeight(.semibold)
//                                                .lineLimit(1)
//
//                                            Text("more")
//                                                .font(.callout.bold())
//                                                .foregroundColor(.gray)
//                                        }
//                                        .padding(.top,7)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                    }
//
//                                }
//                            }
//                        }
//
//                        Spacer(minLength: 20)
//
//                        // List of Buttons
//                        ActionButtons(reel: reel)
//
//                    }
//                }
                UserInfo(reel: reel)
                .foregroundColor(.white)
//                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

struct UserInfo: View{
    @State private var showMore = false
    var reel: Reel
    var body: some View{
        
        VStack{
            HStack(alignment: .bottom) {
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 15) {
                        Image("profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                        Text("Tien Dao")
                            .font(.callout.bold())
                        
                        Button {
                            
                        } label: {
                            Text("Follow")
                                .font(.caption.bold())
                        }
                        
                    }
                    
                    //Title  Custom View...
                    ZStack{
                        if showMore{
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                // Added extra text
                                Text(reel.mediaFile.title + sampleText)
                                    .font(.callout)
                                    .fontWeight(.semibold)
//                                            .lineLimit(1)
                            }
                            .frame(height: 120)
                        }
                        else{
                            
                            Button {
                                
                                withAnimation{showMore.toggle()}
                                
                            } label: {
                                HStack{
                                    
                                    Text(reel.mediaFile.title)
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                    
                                    Text("more")
                                        .font(.callout.bold())
                                        .foregroundColor(.gray)
                                }
                                .padding(.top,7)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }

                        }
                    }
                }
                
                Spacer(minLength: 20)
                
                // List of Buttons
                ActionButtons(reel: reel)
                
            }
        }
    }
}

struct ActionButtons: View{
    var reel: Reel
    
    var body: some View {
        VStack(spacing: 25) {
            Button {
                
            } label: {
                VStack(spacing: 10){
                    Image(systemName: "suit.heart")
                        .font(.title)
                    
                    Text("123K")
                        .font(.caption.bold())
                }
            }

        }
    }
}

let sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
