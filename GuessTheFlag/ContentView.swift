//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Veselin Stefanov on 12.09.20.
//  Copyright © 2020 Veselin Stefanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        Button("Click me!"){
            self.showingAlert = true
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Hello world!"), message: Text("Hi, my name is Veselin Stefanov"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
