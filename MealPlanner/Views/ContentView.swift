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
                        Label("Planner", systemImage: "list.dash.header.rectangle")
                    }
                
                AllPossibleMealsView()
                    .tabItem {
                        Label("All Meals", systemImage: "fork.knife.circle")
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
