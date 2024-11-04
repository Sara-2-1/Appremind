//
//  ContentView.swift
//  Appremind
//
//  Created by Sarah ali  on 02/05/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedMeals = 1
    @State private var mealTimes = [MealTime(startTime: Date(), endTime: Date(), isAMStart: true, isAMEnd: true)]
    @State private var navigateToNext = false
    
    struct MealTime {
        var startTime: Date
        var endTime: Date
        var isAMStart: Bool
        var isAMEnd: Bool
    }
    
    var body: some View {
//        NavigationStack {
            VStack {
                // Image and header text with green background
                ZStack {
                    Color.color1
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 130)
                        .cornerRadius(15)
                    
                    HStack {
                        Image("salad")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 190, height: 150)
                            .padding(.top, 30)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("How many meals do you?")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            
                            Text("want to set ?")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                                .bold()
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                        .padding(.trailing, 15)
                    }
                }
                
                HStack(spacing: 11) {
                    ForEach(1..<4) { number in
                        Button(action: {
                            selectedMeals = number
                            mealTimes = Array(repeating: MealTime(startTime: Date(), endTime: Date(), isAMStart: true, isAMEnd: true), count: selectedMeals)
                        }) {
                            ZStack {
                                if selectedMeals == number {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 35, height: 35)
                                        .offset(x: -1, y: -50)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.color1)
                                        .font(.title)
                                        .offset(x: -1, y: -50)
                                }
                                
                                VStack {
                                    Image(systemName: "fork.knife.circle")
                                        .font(.system(size: 29))
                                        .foregroundColor(.black)
                                        .frame(height: 60)
                                    
                                    Spacer().frame(height: 0)
                                    
                                    Text("\(number)")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding()
                            .frame(width: 117, height: 100)
                            .background(RoundedRectangle(cornerRadius: 15)
                                .stroke(selectedMeals == number ? Color.color1 : Color.gray, lineWidth: 1))
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                        }
                    }
                }
                .padding()
                
                Text("Time of meal ?")
                    .font(.title2)
                    .bold()
                    .padding(.top, 20)
                
                ForEach(0..<selectedMeals, id: \.self) { index in
                    VStack {
                        HStack {
                            Text("From")
                            DatePicker("", selection: $mealTimes[index].startTime, displayedComponents: [.hourAndMinute])
                                .labelsHidden()
                                .frame(width: 100)
                            
                            MovingSquarePicker(isAM: $mealTimes[index].isAMStart)
                        }
                        
                    }
                    .padding(.top, 10)
                }

                Spacer()
                
                HStack {
                    Spacer() // Remove Skip button and its associated code
                    
                    NavigationLink(destination:  nweView(mealTimes: mealTimes)) {
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
            } .navigationBarBackButtonHidden(true)
            .padding()
//        }
    }
}

// Custom AM/PM Picker with Moving Square
struct MovingSquarePicker: View {
    @Binding var isAM: Bool
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 100, height: 40)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.color2)
                .frame(width: 50, height: 40)
                .offset(x: isAM ? -25 : 25)
                .matchedGeometryEffect(id: "switch", in: animation)

            HStack {
                Text("AM")
                    .foregroundColor(isAM ? .white : .black)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation {
                            isAM = true
                        }
                    }
                
                Text("PM")
                    .foregroundColor(isAM ? .black : .white)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation {
                            isAM = false
                        }
                    }
            }
        }
        .frame(width: 100, height: 40)
    }
}

    

#Preview {
    ContentView()
}
