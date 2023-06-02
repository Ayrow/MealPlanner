//
//  ContentView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var splashLoaded = false
    @StateObject var dishesVM = DishesViewViewModel()
    @StateObject var ingredientsVM = IngredientsViewModel()
    
    var body: some View {
        if splashLoaded {
            TabView {
                MainView()
                    .tabItem {
                        Label("Meals Plan", systemImage: "calendar")
                    }
                    .environmentObject(dishesVM)
                
                DishView()
                    .tabItem {
                        Label("Recipes", systemImage: "book")
                    }
                    .environmentObject(dishesVM)
                    .environmentObject(ingredientsVM)
                
                IngredientsView()
                    .tabItem {
                        Label("Ingredients", systemImage: "fork.knife")
                    }
                    .environmentObject(ingredientsVM)
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
