//
//  ReelJourneyHorizontal.swift
//  TabViewCarousel
//
//  Created by Tien Dao on 2022-11-02.
//

import SwiftUI

struct ReelJourneyHorizontal<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list : [T]

    //    Properties...

        @Binding var index : Int
        
        init(index: Binding<Int>,items: [T], @ViewBuilder content: @escaping (T) -> Content){
            self.list = items
            self._index = index
            self.content = content
        }
    
    //    Offset..
        @GestureState var offset : CGFloat = 0
        @State var currentIndex : Int = 0
    
    var body: some View {
        GeometryReader{ proxy in
            let width = proxy.size.width
            HStack(spacing: 0) {
                ForEach(list){ item in
                    content(item)
                        .frame(width: proxy.size.width)
                }
            }
            .offset(x:(CGFloat(currentIndex) * -width))
            .gesture(
                DragGesture()
                    .updating($offset,body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
//                        Updating Current Index...
                        let offsetX = value.translation.width
                        let offsetY = value.translation.height

                        print("offsetX: \(offsetX)")
                        print("offsetY: \(offsetY)")
//                        were going to convert the tranlation into progress (0 - 1)
//                        and round the value...
//                        based on the progress increasing or decreasng the currentIndex....
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1),0)
//                        updating index...
                        currentIndex = index
                        print(currentIndex)
                        print(width)
                    })
                    .onChanged({ value in
                        //                        updating only index...
                        
                        let offsetX = value.translation.width
                        //                        were going to convert the tranlation into progress (0 - 1)
                        //                        and round the value...
                        //                        based on the progress increasing or decreasng the currentIndex....
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1),0)
                    })
            )
        }
    }
}

struct ReelJourneyHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
    }
}
