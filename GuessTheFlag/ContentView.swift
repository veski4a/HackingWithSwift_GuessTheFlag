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
        if number == correctAnswer{
            scoreAlertTitle = "Correct"
            correctAnswersCount += 1
        }
        else{
            scoreAlertTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        
        showingScoreAlert = true
    }
    
    private func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
