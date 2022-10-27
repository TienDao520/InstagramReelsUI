//
//  ReelsView.swift
//  InstagramReelsUI
//
//  Created by Tien Dao on 2022-10-27.
//

import SwiftUI

struct ReelsView: View {
    
    @State var currentReel = ""
    
    var body: some View {
        // Setting Width and height for rotated View
        GeometryReader{proxy in
            let size = proxy.size
            ///Vertical Page Tab View
            TabView(selection: $currentReel){
                ForEach(MediaFileJson){media in
                    VStack{
                        Text("TienDao")
                        
                        Spacer()
                        
//                        ForEach(MediaFileJson){media in
//                                VStack{
//                                    Text("Hello")
//
//                                    Spacer()
//
//                                    Text("Hello")
//                                        .frame(maxHeight: .infinity, alignment: .trailing)
//                                        .foregroundColor(.red)
//                                }
//                                //setting width
//                                .frame(width: size.width)
//                                    .padding()
//
//                        }
                       
                        
                        Text("Description")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
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
