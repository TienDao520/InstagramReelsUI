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
    
    
    let spaceName = "scroll"

    @State var wholeSize: CGSize = .zero
    @State var scrollViewSize: CGSize = .zero

    
    struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value += nextValue() }
    }
    let scrollOffsetSubject: PassthroughSubject<CGFloat, Never> = .init()

    
    @State var currentReel = ""
    
    var body: some View {
        

        GeometryReader{proxy in
            let size = proxy.size
//            Spacer()
            ///Vertical Page Tab View
//            TabView(selection: $currentReel){
            
            ChildSizeReader(size: $wholeSize) {
                ScrollView{
                    ChildSizeReader(size: $scrollViewSize) {

                        VStack {
                            ForEach(0 ..< MediaFileJsonSum.count) {index in
                                var steps = MediaFileJsonSum[index].map { item -> Step in
                                    let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
                                    let player = AVPlayer(url: URL(fileURLWithPath: url))
                                    return Step(player:player,mediaFile: item)
                                }
                                Group {
                                    HorizontalScrollView(steps:steps)
                                        .frame(width: proxy.size.width, height: proxy.size.height)
                                        .id(index)
                                    //                            .rotationEffect(.init(degrees: -90))
                                }
                                
                            }
                        }
                        .background(
                            GeometryReader { proxy in
                                Color.clear.preference(
                                    key: ViewOffsetKey.self,
                                    value: -1 * proxy.frame(in: .named(spaceName)).origin.y
                                )
                            }
                        )
                        .onPreferenceChange(
                            ViewOffsetKey.self,
                            perform: { value in
                                print("offset: \(value)") // offset: 1270.3333333333333 when User has reached the bottom
                                print("height: \(scrollViewSize.height)") // height: 2033.3333333333333
                                
                                if value >= scrollViewSize.height - wholeSize.height {
                                    print("User has reached the bottom of the ScrollView.")
                                } else {
                                    print("not reached.")
                                }
                            }
                        )
                    }
                }
                .coordinateSpace(name: spaceName)

            }
            .onChange(
                of: scrollViewSize,
                perform: { value in
                    print(value)
                }
            )

//            .rotationEffect(.init(degrees: 90))
//            .frame(width: size.height)
//            .tabViewStyle(.page(indexDisplayMode: .never))
//            .frame(width: size.width)
            
//            Spacer()
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        
        
    }
}

struct ViewOffsetKey: PreferenceKey {
  typealias Value = CGFloat
  static var defaultValue = CGFloat.zero
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value += nextValue()
  }
}

struct ChildSizeReader<Content: View>: View {
  @Binding var size: CGSize

  let content: () -> Content
  var body: some View {
    ZStack {
      content().background(
        GeometryReader { proxy in
          Color.clear.preference(
            key: SizePreferenceKey.self,
            value: proxy.size
          )
        }
      )
    }
    .onPreferenceChange(SizePreferenceKey.self) { preferences in
      self.size = preferences
    }
  }
}

struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: Value = .zero

  static func reduce(value _: inout Value, nextValue: () -> Value) {
    _ = nextValue()
  }
}


struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
        
    }
}
