//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Aniket Sharma on 13/04/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Properties
    @State private var scoreTitle = ""
    @State private var playerScore = 0
    @State private var appScore = 0
    @State private var count = 0
    @State private var showingScore = false
    @State private var showingResult = false
    @State private var finalPlayerScore = 0
    @State private var finalAppScore = 0
    var moves = ["rock","paper","scissor"]
    @State private var correctAnswer = Int.random(in: 0...2)
    var emoji = ["👊","📜","✂️"]
    
    
    var body: some View {
        ZStack {
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
                .ignoresSafeArea()
            VStack(spacing:20){
                Text("Rock Paper Scissor")
                    .bold()
                    .foregroundStyle(.primary)
                    .font(.largeTitle)
                VStack(spacing:20){
                    
                    Text("choose your move")
                    ForEach(0..<3){ number in
                        Button{
                            buttonTapped(number,correctAnswer)
                        }
                    label: {
                        Text("\(emoji[number]) \(moves[number])")
                            .font(.system(size: 50))
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .padding(.vertical , 20)
                            .background(.regularMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                            .shadow(radius: 20)
                    }
                    }
                }
                
                HStack{
                    Text("Your Score: \(playerScore)")
                    Text("Computer Score: \(appScore)")
                }

            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue" , action: askQuestion)
        } message:{
            Text("Computer opted \(moves[correctAnswer])")
    }
        .alert("GAME OVER", isPresented: $showingResult){
            Button("Restart" , action: askQuestion)
        } message:{
            Text(finalPlayerScore > finalAppScore ? "Congratulations you beat Computer by \(finalPlayerScore - finalAppScore) points" : "Better luck next time, you lose from Computer by \(finalAppScore - finalPlayerScore) points")
    }
        
        
    }
    
    // MARK: Helper Functions
    func buttonTapped(_ number: Int,_ correctAnswer: Int){
        let userMove = moves[number]
        let computerMove = moves[correctAnswer]
        

            if userMove == computerMove {
                scoreTitle = "It's a Draw!"
            } else if (userMove == "rock" && computerMove == "scissor") ||
                      (userMove == "scissor" && computerMove == "paper") ||
                      (userMove == "paper" && computerMove == "rock") {
                scoreTitle = "You Win! +1"
                playerScore += 1
            } else {
                scoreTitle = "You Lose! Oops!"
                appScore += 1
            }
        
        count += 1
        
        if count == 10{
            finalPlayerScore = playerScore
            finalAppScore = appScore
            playerScore = 0
            appScore = 0
            count = 0
            showingScore = false
            showingResult = true
        }
        showingScore = true
    }
    
    func askQuestion(){
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
