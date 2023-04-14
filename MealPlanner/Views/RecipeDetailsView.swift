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
                
                if meal.ingredients.isEmpty == false {
                    ForEach(meal.ingredients.sorted {$0!.name < $1!.name}, id:\.self) { ingredient in
                        Text(ingredient!.name)
                    }
                } else {
                    Text("No ingredients added yet")
                }
            
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
                Text("Recipe Guide")
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
