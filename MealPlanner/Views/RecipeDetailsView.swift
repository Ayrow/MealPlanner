//
//  RecipeDetailsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 12/04/2023.
//

import SwiftUI

struct RecipeDetailsView: View {
    var meal: Dish
    
    var body: some View {
        
        Form {
            
            Section {
                Text(meal.name)
            } header: {
                Text("Dish Name")
            }
            
            Section {
                Text("hello")
            } header: {
                Text("Ingredients")
            }
            
            Section {
                if let linkProvided = meal.recipe, meal.recipe != "" {
                    Link("Check the recipe guide", destination: URL(string: linkProvided)!)
                    
                } else {
                    Text("No recipe guide provided yet.")
                }
            } header: {
                Text("Recipe Details")
            }
            
        }
        .navigationTitle(meal.name)
        
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(meal: Dish.example)
    }
}
