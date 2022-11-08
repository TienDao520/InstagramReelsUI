//
//  ReelsView.swift
//  CarouselAndTabView
//
//  Created by Tien Dao on 2022-11-07.
//

import SwiftUI

struct ReelsView: View {
    
    @State var currentReel = ""
    
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            Spacer()
            TabView(selection: $currentReel){
                CarouselView(cards: [
                    CarouselCard(id: 0, text: "This is some pretty long text.", image: "square.dashed"),
                    CarouselCard(id: 1, text: "This is also some pretty long text.", image: "square"),
                    CarouselCard(id: 2, text: "This one has a circle.", image: "circle")
                ])
//                .frame(width: size.width)
//                .frame(width: size.width)
                .rotationEffect(.init(degrees: -90))
                CarouselView(cards: [
                    CarouselCard(id: 0, text: "This is some pretty long text.", image: "square.dashed"),
                    CarouselCard(id: 1, text: "This is also some pretty long text.", image: "square"),
                    CarouselCard(id: 2, text: "This one has a circle.", image: "circle")
                ])
//                .frame(width: size.width)
                .rotationEffect(.init(degrees: -90))
            }
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)

            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
            Spacer()


        }
        .ignoresSafeArea(.all)
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
    }
}
