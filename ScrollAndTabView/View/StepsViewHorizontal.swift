//
//  StepsViewHorizontal.swift
//  ScrollAndTabView
//
//  Created by Tien Dao on 2022-11-03.
//

import SwiftUI
import AVFoundation


struct StepsViewHorizontal: View {
    
//    var MediaFile: [MediaFile]
    
//    @State private var selection: Int = .zero
    
    @State var currentSelection = ""


    // Extracting AVPlayer from media Files
    @State var steps = MediaFileJson.map { item -> Step in
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        return Step(player:player,mediaFile: item)
    }
    
    
//    @State var steps: [Step]
//    init(currentSelection: String = "", steps: [Step]) {
//        self.currentSelection = currentSelection
//        self.steps = steps
//    }
//    var steps = MediaFile.map { item -> Step in
//        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
//        let player = AVPlayer(url: URL(fileURLWithPath: url))
//        return Step(player:player,mediaFile: item)
    //}
    
    
    var body: some View {
        // Setting Width and height for rotated View
        GeometryReader{proxy in
            let size = proxy.size
            Spacer()

            ///Vertical Page Tab View
            TabView(selection: $currentSelection){
                ForEach($steps){$step in
                    StepsPlayer(step: $step)
                    //setting width
                    .frame(width: size.width)
                    .padding()
                    //Rotating Content
//                    .rotationEffect(.init(degrees: -90))
                    .ignoresSafeArea(.all, edges: .top)
                }
            }
//            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
//            .frame(width: size.width)

            Spacer()
        }
        
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
    }
}

struct StepsPlayer: View{
    
    @Binding var step: Step
    
    //Expanding title when it is tapped
    @State var showMore = false
    
    var body: some View {
            Group{
                VStack{
                    // Check nil value
                    if let player = step.player{
                        ZStack{
                            CustomVideoPlayer(player: player)
                            
                            // Control playing video based on offset
                            GeometryReader { proxy -> Color in
                                let minX = proxy.frame(in: .global).minX
                                
                                let size = proxy.size
                                print("minX: \(minX)")
                                print("size.width: \(size.width)")
                                
                                let minY = proxy.frame(in: .global).minY

                                DispatchQueue.main.async {
                                    if -minX < (size.width / 2) && minX < (size.width / 2) && -minY < (size.height / 2) && minY < (size.height / 2){
//                                        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                                        player.play()
                                        player.isMuted = true
                                    }
                                    else{
                                        player.pause()
                                    }
                                }
                                return Color.clear
                            }

                            

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
                                                Text(step.mediaFile.title + sampleText)
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

                                                    Text(step.mediaFile.title)
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
//                                ActionButtons(reel: reel)

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

let sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."


struct StepsViewHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        StepsViewHorizontal()
    }
}
