//
//  HorizontalScrollView.swift
//  ScrollAndTabView
//
//  Created by Tien Dao on 2022-11-08.
//

import SwiftUI
import AVFoundation

import Combine


struct HorizontalScrollView: View {
    @State var steps = MediaFileJson.map { item -> Step in
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        return Step(player:player,mediaFile: item)
    }
    
    @State var currentSelection = ""
    
    @State var textInput = "0"

    
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            let countStep = steps.count

            
            
                TabView(selection: $currentSelection) {
                    
//                    LazyHStack(spacing: .zero) {

                        ForEach(0 ..< countStep){index in
//                            ForEach($steps){$step in
//                        ForEach($steps.indices){index in
                            
                            StepsPlayer(step: $steps[index])

                            //setting width
                            .frame(width: size.width)
                            .id(index)

                            
                        }
//                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

        }
    }
}

struct HorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollView()
    }
}
