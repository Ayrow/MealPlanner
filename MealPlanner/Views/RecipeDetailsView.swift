//
//  RecipeDetailsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 12/04/2023.
//

import SwiftUI

struct RecipeDetailsView: View {
    var meal: Meal
    var body: some View {
        
        Form {
            
            Section {
                Text(meal.name)
            }
            
            Section {
                if meal.ingredients?.isEmpty != false && meal.ingredients != nil {
                    List(meal.ingredients!, id:\.self) { ingredient in
                        Text(ingredient)
                    }
                } else {
                    Text("No ingredients addes yet.")
                }
            } header: {
                Text("Ingredients")
            }
            
            Section {
                if let linkProvided = meal.recipe {
                    Link("Check the full recipe", destination: linkProvided)
                } else {
                    Text("No recipe guide provided yet.")
                }
            }
            
        }
        
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(meal: Meal.example)
    }
}
