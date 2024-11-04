//
//  nweView.swift
//  Appremind
//
//  Created by Sarah ali  on 02/05/1446 AH.
//

import SwiftUI

struct nweView: View {
    var mealTimes: [ContentView.MealTime]
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    @State private var foodName = ""
    @State private var expiryDateText = ""
    
    var body: some View {

            VStack {
                ZStack {
                    Color.color1
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 130)
                        .cornerRadius(15)
                    
                    HStack {
                        Image("salad")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 170)
                           // .padding(.top, 20)
                            .padding(.leading, 20)
                        Spacer()
                        
                        VStack {
                            Text("Add Food")
                                .font(.system(size: 30))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                                .padding(.top, 23)
                                .padding(.bottom, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                     
                    }
                }
                Spacer()
            //    .offset(y: -50)
                
                ScrollView {
                    VStack(spacing: 25) {  // Increased spacing between fields
                        HStack {
                            Text("Food Name")
                                .font(.headline)
                                .padding(.trailing, 10)
                            
                            TextField("Enter Food Name", text: $foodName)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.color1, lineWidth: 1))
                        }
                        
                        HStack {
                            Text("Expiry Date")
                                .font(.headline)
                                .padding(.trailing, 10)
                            
                            ZStack(alignment: .trailing) {
                                TextField("Select Date", text: $expiryDateText)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.color1, lineWidth: 1))
                                    .onTapGesture {
                                        showDatePicker.toggle()
                                    }
                                
                                Image(systemName: "calendar")
                                    .padding()
                                    .onTapGesture {
                                        showDatePicker.toggle()
                                    }
                            }
                        }
                        
                        if showDatePicker {
                            VStack {
                                Text("Select a Date")
                                    .font(.headline)
                                    .padding(.bottom, 10)
                                
                                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .frame(maxHeight: 400)
                                    .padding()
                                
                                Button("Done") {
                                    expiryDateText = selectedDate.formatted(date: .abbreviated, time: .omitted)
                                    showDatePicker = false
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.color1))
                                .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding()
                    .padding(.bottom, 80)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: FinalView(mealTimes: mealTimes, foodItems: [(foodName, selectedDate)])) {
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
                Spacer()

            }.navigationBarBackButtonHidden(true)
            .padding()
//        }
    }
}


#Preview {
    nweView(mealTimes: [])
}
