//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Veselin Stefanov on 12.09.20.
//  Copyright © 2020 Veselin Stefanov. All rights reserved.
//

import SwiftUI

struct FlagImage: View{
    var name: String
    
    var body: some View{
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule()
            .stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var correctAnswersCount = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScoreAlert = false
    @State private var scoreAlertTitle = ""
    
    @State private var clickedButtonNumber: Int? = nil
    @State private var rotationAmountForCorrectFlag = 0.0
    @State private var opacityAmountForIncorrectFlags = 1.0
    @State private var offsetAmount: CGFloat = CGFloat.zero
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3){ number in
                    Button(action:{
                        self.flagTapped(number)
                    }){
                        FlagImage(name: self.countries[number])
                    }
                    .rotation3DEffect(clickedButtonNumber == number && number == correctAnswer ? .degrees(rotationAmountForCorrectFlag) : .zero,
                        axis: (x: 0.0, y: 0.0, z: 1.0))
                    .opacity(clickedButtonNumber != number && number != correctAnswer ? opacityAmountForIncorrectFlags : 1.0)
                    .offset(x: clickedButtonNumber == number && number != correctAnswer ? offsetAmount : 0.0)
                }
                
                Text("Correct answers: \(self.correctAnswersCount)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                
                Spacer()
            }
            .alert(isPresented: $showingScoreAlert){
                Alert(title: Text(scoreAlertTitle), message: Text("Your score is \(self.correctAnswersCount)"), dismissButton: .default(Text("Continue")){
                        self.askQuestion()
                    })
            }
        }
    }
    
    private func flagTapped(_ number: Int){
        clickedButtonNumber = number
        
        if number == correctAnswer{
            scoreAlertTitle = "Correct"
            correctAnswersCount += 1
            
            withAnimation{
                rotationAmountForCorrectFlag += 360
                opacityAmountForIncorrectFlags = 0.25
            }
        }
        else{
            scoreAlertTitle = "Wrong! That’s the flag of \(countries[number])"
            
            offsetAmount = 10.0
            
            withAnimation(Animation.interpolatingSpring(stiffness: 200, damping: 10, initialVelocity: 200).repeatCount(1, autoreverses: true)){
                offsetAmount = CGFloat.zero
            }
        }
        
        showingScoreAlert = true
    }
    
    private func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        clickedButtonNumber = nil
        opacityAmountForIncorrectFlags = 1.0
        offsetAmount = CGFloat.zero
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
