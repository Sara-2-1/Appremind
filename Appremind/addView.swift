//
//  addView.swift
//  Appremind
//
//  Created by Sarah ali  on 02/05/1446 AH.
//

import SwiftUI

struct addView: View {
    var body: some View {
        NavigationView { // Wrap everything in a NavigationView
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image("Image2")
                        .scaledToFit()
                        .padding()
                    
                    Text("Remind me")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    Text("An application that helps users manage their eating habits by sending notifications for meal times and reminding them when food expires.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        // NavigationLink to navigate to ContentView
                        NavigationLink(destination: ContentView()) {
                            HStack {
                                Text("Next")
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
                        } .navigationBarBackButtonHidden(true)
                    }
                }
            
                            
#Preview {
    addView()
}
