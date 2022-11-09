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
    
    struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value += nextValue() }
    }
    
    let scrollOffsetSubject: PassthroughSubject<CGFloat, Never> = .init()

    
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            let countStep = steps.count
            Spacer()
            ScrollViewReader { value in
                HStack{
                    Button("<< First Step") {
                        value.scrollTo(0)
                    }
                    TextField(
                      "Hint Text",
                      text: $textInput,
                      onCommit: {
                          value.scrollTo(Int(textInput))
                      }
                    )
                    .keyboardType(.default)
                    .padding()
                    .foregroundColor(.orange)
                    
                    Button("Last Step >>") {
                        value.scrollTo(countStep-1)
                    }
                }

                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack(spacing: .zero) {
                        
                        ForEach(0 ..< countStep){index in
//                            ForEach($steps){$step in
//                        ForEach($steps.indices){index in
                            
                            StepsPlayer(step: $steps[index])

                            //setting width
                            .frame(width: size.width)
                            .id(index)
    //                        .padding(2)
        //                    .gesture(DragGesture())
                            //Rotating Content
        //                    .rotationEffect(.init(degrees: -90))
        //                    .ignoresSafeArea(.all, edges: .top)


                        }
                        

                    }
                    .background( GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollOffsetKey.self, value: -(geometry.frame(in: .named("scroll")).origin.x))
                    })
                    .onPreferenceChange(ScrollOffsetKey.self) { scrollOffsetSubject.send($0)}
//                    .frame(minWidth: size.width, maxWidth: .infinity)
                }
                .coordinateSpace(name: "scroll")
                .onReceive(scrollOffsetSubject.debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)) { newValue in
                    let currentIndex = newValue/size.width
                    let near = currentIndex < 1 ? currentIndex : currentIndex.truncatingRemainder(dividingBy: CGFloat(Int(currentIndex)))
                    let newIndex = near > 0.5 ? Int(currentIndex) + 1 : Int(currentIndex)
                    withAnimation { value.scrollTo(newIndex, anchor: .center) }
                }
//                .frame(minWidth: size.width, maxWidth: .infinity)
            }
            
//            Spacer()
            
            
            
//                Spacer()
//                TabView(selection: $currentSelection){
//                    ForEach($steps){$step in
//                        StepsPlayer(step: $step)
//                        //setting width
//    //                    .frame(width: size.width)
//                        .padding()
//
//                        //Rotating Content
//    //                    .rotationEffect(.init(degrees: -90))
//    //                    .ignoresSafeArea(.all, edges: .top)
//
//
//                    }
//
//                }
//                .gesture(DragGesture())
//    //            .frame(width: size.height)
//                .tabViewStyle(.page(indexDisplayMode: .never))
//                Spacer()
            
            
            
            
        }
    }
}

struct HorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollView()
    }
}
