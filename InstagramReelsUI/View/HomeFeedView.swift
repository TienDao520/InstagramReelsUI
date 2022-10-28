//
//  HomeFeedView.swift
//  InstagramReelsUI
//
//  Created by Tien Dao on 2022-10-27.
//

import SwiftUI

struct HomeFeedView: View {
    //Hiding Tab Bar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
//    @State var currentTab = "house.fill"
    @State var currentTab = "Reels"
    
    var body: some View {
        ///Custom Tab View
        VStack(spacing: 0) {
            TabView(selection: $currentTab){
                Text("Home")
                    .tag("house.fill")
                Text("Search")
                    .tag("magnifyingglass")
                
                
                
                ///Reels View
                ReelsView()
                    .tag("Reels")
                
                Text("Liked")
                    .tag("suit.heart")
                Text("Home")
                    .tag("person.circle")
            }
            HStack(spacing: 0){
                ///simply creating array of images
                ForEach(["house.fill","magnifyingglass", "Reels", "suit.heart", "person.circle"], id: \.self){image in
                    TabBarButton(image: image, isSystemImage: image != "Reels", currentTab: $currentTab)
                    
                }
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            .overlay(Divider(), alignment: .top)
            //If view is changed to reels color to black
            //In iOS 15 it will automatically fill safe area for bottom tabs area
            .background(currentTab == "Reels" ? .black : .clear)
            
        }
        
        
    }
}

struct HomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedView()
//            .preferredColorScheme(.light)
    }
}

// Tab Bar Button

struct TabBarButton: View{
    var image: String
    var isSystemImage: Bool
    @Binding var currentTab: String
    
//    @State var currentTab: String
    
    var body: some View{
        Button {
            withAnimation{currentTab = image}
        } label: {
            ZStack{
                if isSystemImage{
                    Image(systemName: image)
                        .font(.title2)
                }
                else{
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
            }
            .foregroundColor(currentTab == image ? currentTab == "Reels" ? .white : .primary : .gray)
            .frame(maxWidth: .infinity)
        }
        
    }
}
