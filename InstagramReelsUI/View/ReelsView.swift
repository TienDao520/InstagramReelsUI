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
        ///Vertical Page Tab View
        TabView(selection: $currentReel){
            ForEach(MediaFileJson){media in
                Color.red
                    .padding()
            }
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
