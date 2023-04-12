//
//  ContentView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var splashLoaded = false
    var body: some View {
        if splashLoaded {
            TabView {
                MainView()
                    .tabItem {
                        Label("Meals Plan", systemImage: "calendar")
                    }
                
                RecipesView()
                    .tabItem {
                        Label("Recipes", systemImage: "book")
                    }
            }
            
        } else {
            LaunchScreen(splashLoaded: $splashLoaded)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
