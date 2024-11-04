//
//  HomeView.swift
//  Appremind
//
//  Created by Sarah ali  on 02/05/1446 AH.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color.white.ignoresSafeArea()
                
                VStack {
                    Image("Image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 370, height:600)
                        .padding(.bottom, -110) // Reduced padding below the image
                    
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 5) // Reduced padding between the title and the subtitle
                    
                    Text("Help to Remind you, Manage your Meals")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal) // Only horizontal padding for better spacing control
                    
                    Spacer() // Keeps the bottom elements aligned properly
                    
                    HStack {
                        Spacer()
                        
                        // Use NavigationLink to link to page 2 (Welcom2)
                        NavigationLink(destination: addView()) {
                            HStack {
                                Image(systemName: "arrow.forward")
                                    .resizable()
                                    .frame(width: 20, height: 15)
                            }
                            .foregroundColor(.color2)
                            .padding(.trailing)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    HomeView()
}
