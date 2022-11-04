//
//  ReelsView.swift
//  ScrollAndTabView
//
//  Created by Tien Dao on 2022-11-03.
//

import SwiftUI
import Combine
import AVFoundation

struct ReelsView: View {
    
//    @State var steps = MediaFileJson.map { item -> Step in
//        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
//        let player = AVPlayer(url: URL(fileURLWithPath: url))
//        return Step(player:player,mediaFile: item)
//    }
    
    
    struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value += nextValue() }
    }
    let scrollOffsetSubject: PassthroughSubject<CGFloat, Never> = .init()

    
    @State var currentReel = ""
    
    var body: some View {
//        GeometryReader { proxy in
//            ScrollViewReader { scroll in
//
//                ScrollView(.vertical, showsIndicators: true) {
//                    LazyVStack(spacing: .zero) {
//                        ForEach(0 ..< MediaFileJsonSum.count) {index in
//                            var steps = MediaFileJsonSum[index].map { item -> Step in
//                                let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
//                                let player = AVPlayer(url: URL(fileURLWithPath: url))
//                                return Step(player:player,mediaFile: item)
//                            }
//
//                            StepsViewHorizontal( steps: steps)
//                                .frame(width: proxy.size.width, height: proxy.size.height)
//                                .id(index)
//
//                        }
//                    }
//                    .background( GeometryReader { geometry in
//                        Color.clear
//                            .preference(key: ScrollOffsetKey.self, value: -(geometry.frame(in: .named("scroll")).origin.y))
//                    })
//                    .onPreferenceChange(ScrollOffsetKey.self) { scrollOffsetSubject.send($0)}
//                }
//                .coordinateSpace(name: "scroll")
//                .onReceive(scrollOffsetSubject.debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)) { newValue in
//                    let currentIndex = newValue/proxy.size.height
//                    let near = currentIndex < 1 ? currentIndex : currentIndex.truncatingRemainder(dividingBy: CGFloat(Int(currentIndex)))
//                    let newIndex = near > 0.5 ? Int(currentIndex) + 1 : Int(currentIndex)
//                    withAnimation { scroll.scrollTo(newIndex, anchor: .center) }
//                }
//                .onAppear {
//                    UIScrollView().decelerationRate = .fast
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.all)

        GeometryReader{proxy in
            let size = proxy.size
            Spacer()
            
            ///Vertical Page Tab View
            TabView(selection: $currentReel){
                ForEach(0 ..< MediaFileJsonSum.count) {index in
                    var steps = MediaFileJsonSum[index].map { item -> Step in
                        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
                        let player = AVPlayer(url: URL(fileURLWithPath: url))
                        return Step(player:player,mediaFile: item)
                    }

                    StepsViewHorizontal( steps: steps)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .id(index)
                        .rotationEffect(.init(degrees: -90))
//                        .ignoresSafeArea(.all, edges: .top)


                }
            }
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
            Spacer()
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
