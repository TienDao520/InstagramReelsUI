//
//  ReelsView.swift
//  TabViewCarousel
//
//  Created by Tien Dao on 2022-11-02.
//

import SwiftUI
import AVFoundation

var MediaFileJsonReel = [MediaFileJson, MediaFileJson2, MediaFileJson3]

// this is our array of arrays
var groups = [[String]]()

// we create three simple string arrays for testing
var groupA = ["England", "Ireland", "Scotland", "Wales"]
var groupB = ["Canada", "Mexico", "United States"]
var groupC = ["China", "Japan", "South Korea"]



var postHorizontal1 : [Journey] = [Journey(postImage:"post1"),Journey(postImage:"post2"),Journey(postImage:"post3"),Journey(postImage:"post4"),Journey(postImage:"post5"),Journey(postImage:"post6")]
var postHorizontal2 : [Journey] = [Journey(postImage:"post1"),Journey(postImage:"post2"),Journey(postImage:"post3"),Journey(postImage:"post4"),Journey(postImage:"post5"),Journey(postImage:"post6")]
var postHorizontal3 : [Journey] = [Journey(postImage:"post1"),Journey(postImage:"post2"),Journey(postImage:"post3"),Journey(postImage:"post4"),Journey(postImage:"post5"),Journey(postImage:"post6")]
var postHorizontal4 : [Journey] = [Journey(postImage:"post1"),Journey(postImage:"post2"),Journey(postImage:"post3"),Journey(postImage:"post4"),Journey(postImage:"post5"),Journey(postImage:"post6")]


struct ReelsView: View {
    
    @State var currentReel = ""
    // Extracting AVPlayer from media Files
    @State var reels = MediaFileJson.map { item -> Reel in
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        return Reel(player:player,mediaFile: item)

    }
    
    // then add them all to the "groups" array
    @State var currentIndexVertical : Int = 0
    @State var currentIndexHorizontal : Int = 0
    
    @State var postHorizontal : [Journey] = [Journey(postImage:"post1"),Journey(postImage:"post2"),Journey(postImage:"post3"),Journey(postImage:"post4"),Journey(postImage:"post5"),Journey(postImage:"post6")]

    
//    @State var postVertical : [Journey] = [Journey(postImage:"post1"),Journey(postImage:"post2"),Journey(postImage:"post3"),Journey(postImage:"post4"),Journey(postImage:"post5"),Journey(postImage:"post6")]
    
    

    
    
//    postVertical.append(postHorizontal1)
    var postVertical = [postHorizontal1, postHorizontal2, postHorizontal3, postHorizontal4]
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            ///Vertical Page Tab View
//            ReelJourneyVertical(index: $currentIndexVertical, items: postVertical) { post in
//                GeometryReader{ proxy in
//                    let size = proxy.size
//
//                    Image(post[].postImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: size.width)
//                        .cornerRadius(12)
//
//                }
//        }
            
            
                ReelJourneyHorizontal(index: $currentIndexHorizontal, items: postHorizontal) { post in
                    GeometryReader{ proxy in
                        let size = proxy.size

                        Image(post.postImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width)
                            .cornerRadius(12)

                    }
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
    }
}



struct ReelsPlayer: View{
    
    @Binding var reel: Reel
    
    //Expanding title when it is tapped
    @State var showMore = false
    
    var body: some View {
            Group{

                VStack{
                    // Check nil value
                    if let player = reel.player{
                        ZStack{
                            CustomVideoPlayer(player: player)
                            
                            // Control playing video based on offset
                            GeometryReader { proxy -> Color in
                                let minY = proxy.frame(in: .global).minY
                                let size = proxy.size
                                print(MediaFileJsonReel[1])
                                DispatchQueue.main.async {
                                    if -minY < (size.height / 2) && minY < (size.height / 2){
//                                        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                                        player.play()
                                    }
                                    else{
                                        player.pause()
                                    }
                                }
                                return Color.clear
                            }
//
                            

                            Color.black.opacity(showMore ? 0.35: 0)
                                .onTapGesture {
                                    //Closing
                                    withAnimation{showMore.toggle()}
                                }
                        }
                        
                        
                        
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
                                            .onTapGesture {
                                                withAnimation {
                                                    showMore.toggle()
                                                }
                                            }
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
        //                UserInfo(reel: reel)
                        .foregroundColor(.white)
        //                .padding(.horizontal)
                        
        //                .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
            }
        
        
    }
}


struct ActionButtons: View{
    var reel: Reel
    
    var body: some View {
        HStack(spacing: 25) {
            Button {
                
            } label: {
                VStack(spacing: 10){
                    Image(systemName: "suit.heart")
                        .font(.title)
                    
//                    Text("123K")
//                        .font(.caption.bold())
                }
            }
            
            Button {
                
            } label: {
                VStack(spacing: 10){
                    Image(systemName: "bubble.right")
                        .font(.title)
                    
//                    Text("123K")
//                        .font(.caption.bold())
                }
            }
            
            Button {
                
            } label: {
                VStack(spacing: 10){
                    Image(systemName: "paperplane")
                        .font(.title)
                    
//                    Text("123K")
//                        .font(.caption.bold())
                }
            }
            
            Button {
                
            } label: {
            
                    Image("menu")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .rotationEffect(.init(degrees: 90))
                    
//                    Text("123K")
//                        .font(.caption.bold())
                
            }
            

        }
    }
}

let sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
