//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Veselin Stefanov on 12.09.20.
//  Copyright © 2020 Veselin Stefanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20){
            HStack(spacing: 10){
                Text("Cell 1")
                Spacer()
                Text("Cell 2")
                Spacer()
                Text("Cell 3")
            }
            
            Spacer()
            
            HStack(spacing: 10){
                Text("Cell 4")
                Spacer()
                Text("Cell 5")
                Spacer()
                Text("Cell 6")
            }
            
            Spacer()
            
            HStack(spacing: 10){
                Text("Cell 7")
                Spacer()
                Text("Cell 8")
                Spacer()
                Text("Cell 9")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
