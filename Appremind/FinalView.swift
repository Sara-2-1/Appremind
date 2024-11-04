//
//  FinalView.swift
//  Appremind
//
//  Created by Sarah ali  on 02/05/1446 AH.
//

import SwiftUI

struct FinalView: View {
    var mealTimes: [ContentView.MealTime]
    var foodItems: [(name: String, expiryDate: Date)]
    
    @State private var currentTime = Date()
    @State private var countdowns: [TimeInterval] = []
    @State private var showConfetti = false // State variable to trigger confetti
    
    // Timer reference
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack { // Use ZStack to overlay the confetti over the main view
            VStack {
                Image("Image3") // Replace with your actual image asset
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.top)
                
                // Title for Meal Countdown aligned to the left
                Text("Meal Countdown")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                    .padding(.leading) // Add padding for alignment
                    .padding(.top)
                
                ForEach(0..<mealTimes.count, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading , spacing: 1) {
                            HStack {
                                Image(systemName: "clock")
                                    .resizable() // Make the icon resizable
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.gray)
                                    .offset(y: 10) // Moves the clock icon down slightly
                                Text("Meal \(index + 1)")
                                    .font(.headline)
                            }
                            
                            Text("Time: \(mealTimes[index].startTime.formatted(date: .omitted, time: .shortened)) to \(mealTimes[index].endTime.formatted(date: .omitted, time: .shortened))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.leading, 33) // Adjust this value to move the text slightly to the right
                                
                        }
                        Spacer()
                        
                        // Display the countdown timer or a "Done" button when finished
                        if index < countdowns.count {
                            if countdowns[index] > 0 {
                                Text(countdownString(for: countdowns[index]))
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.green)
                            } else {
                                // When countdown reaches zero, show the "Done" button
                                Button(action: {
                                    showConfetti = true // Trigger confetti when "Done" is pressed
                                    print("Meal \(index + 1) finished")
                                }) {
                                    Text("Done")
                                        .bold()
                                        .padding(8)
                                        .background(Color.green)
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(width: 350, height: 100) // Set consistent width and height
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(radius: 5)
                    )
                    .padding(.vertical, 5)
                }
                
                Spacer()
                
                // Title for Food Expiry Info aligned to the left
                Text("Food Expiry Info")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                    .padding(.leading) // Add padding for alignment
                    .padding(.top)
                
                ForEach(0..<foodItems.count, id: \.self) { index in
                    FoodItemView(foodName: foodItems[index].name, expiryDate: foodItems[index].expiryDate)
                }
                
                Spacer()
            }  .navigationBarBackButtonHidden(false)
            .padding()
            .onAppear {
                // Initialize countdowns with the same count as mealTimes
                countdowns = mealTimes.map { mealTime in
                    let timeInterval = mealTime.startTime.timeIntervalSince(Date())
                    return max(timeInterval, 0) // No negative countdowns
                }
                
                // Start the countdown timer
                startCountdownTimer()
            }
            .onDisappear {
                // Invalidate the timer when the view disappears
                timer?.invalidate()
            }
            
            // Confetti will appear on top of the current view
            if showConfetti {
                ConfettiView()
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity) // Add fade transition for smooth appearance
                    .onAppear {
                        // Hide confetti after 3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showConfetti = false
                        }
                    }
            }
        }
    }
    
    // Function to update the countdown timer every second
    func startCountdownTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            currentTime = Date()
            countdowns = mealTimes.map { mealTime in
                let timeInterval = mealTime.startTime.timeIntervalSince(currentTime)
                return max(timeInterval, 0) // No negative countdowns
            }
        }
    }
    
    // Formatting the countdown time into a readable format
    func countdownString(for interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

// View for displaying the food item expiration and status
struct FoodItemView: View {
    var foodName: String
    var expiryDate: Date
    
    @State private var currentTime = Date()
    
    var body: some View {
        let daysLeft = calculateDaysLeft(expiryDate: expiryDate)
        let color = getColor(for: daysLeft)
        
        HStack {
            Image(systemName: "fork.knife.circle")
                .resizable() // Make the icon resizable
            .frame(width: 28, height: 28) // Standardize the size
                .foregroundColor(.gray)
                .padding(.leading, 0)
                
            
            VStack(alignment: .leading) {
                Text(foodName)
                    .font(.headline)
                
                Text("\(daysLeft) days left")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            // Background color for remaining days
            Text(daysLeft > 15 ? "Long" : (daysLeft > 10 ? "Middle" : "Short"))
                .font(.subheadline)
                .bold()
                .padding(10)
                .background(color)
                .cornerRadius(15)
                .foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.vertical,30)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(color, lineWidth: 2)
        )
        .padding(.horizontal)
        .frame(width: 380, height: 100) // Set consistent width and height
        .onAppear {
            currentTime = Date()
        }
    }
    
    // Calculate days left until expiry
    func calculateDaysLeft(expiryDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: currentTime, to: expiryDate)
        return components.day ?? 0
    }
    
    // Get the background color based on days left
    func getColor(for daysLeft: Int) -> Color {
        if daysLeft <= 10 {
            return Color.red
        } else if daysLeft <= 15 {
            return Color.yellow
        } else {
            return Color.green
        }
    }
}

// ConfettiView implementation remains unchanged
struct ConfettiView: UIViewControllerRepresentable {
    class ConfettiViewController: UIViewController {
        private var emitterLayer: CAEmitterLayer!

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear // Keep the view transparent for overlay effect
            setupEmitterLayer()
            startConfetti()
        }

        private func setupEmitterLayer() {
            emitterLayer = CAEmitterLayer()
            emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: -10)
            emitterLayer.emitterSize = CGSize(width: view.bounds.size.width, height: 1)
            emitterLayer.emitterShape = .line
            
            let colors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple]
            var cells: [CAEmitterCell] = []
            
            for color in colors {
                let cell = createConfettiCell(color: color)
                cells.append(cell)
            }
            
            emitterLayer.emitterCells = cells
            view.layer.addSublayer(emitterLayer)
        }

        private func createConfettiCell(color: UIColor) -> CAEmitterCell {
            let cell = CAEmitterCell()
            cell.birthRate = 80
            cell.lifetime = 14.0
            cell.velocity = 100
            cell.velocityRange = 50
            cell.emissionRange = .pi // emit in a full circle
            
            // Increase scale for bigger confetti
            cell.contents = createConfettiLayer(color: color)
            cell.scale = 0.2 // Adjusted scale for larger confetti
            cell.scaleRange = 0.2 // Adjusted scale range
            cell.yAcceleration = 100
            cell.alphaSpeed = -0.3
            
            return cell
        }

        private func createConfettiLayer(color: UIColor) -> CGImage? {
            let size = CGSize(width: 20, height: 20) // Increased size for larger confetti
            UIGraphicsBeginImageContext(size)
            color.setFill()
            let rect = CGRect(origin: .zero, size: size)
            UIRectFill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image?.cgImage
        }

        func startConfetti() {
            emitterLayer.birthRate = 1
        }

        func stopConfetti() {
            emitterLayer.birthRate = 0
        }
    }

    func makeUIViewController(context: Context) -> ConfettiViewController {
        return ConfettiViewController()
    }

    func updateUIViewController(_ uiViewController: ConfettiViewController, context: Context) {
        // Update the view controller if needed
    }
}



