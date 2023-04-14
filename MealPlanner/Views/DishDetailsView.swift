//
//  RecipeDetailsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 12/04/2023.
//

import SwiftUI

struct DishDetailsView: View {
    var dish: Dish
    
    var body: some View {
        
        Form {
            
            Section {
                Text(dish.name)
            } header: {
                Text("Dish Name")
            }
            
            Section {
                
                if dish.ingredients.isEmpty == false {
                    ForEach(dish.ingredients.sorted {$0!.name < $1!.name}, id:\.self) { ingredient in
                        Text(ingredient!.name)
                    }
                } else {
                    Text("No ingredients added yet")
                }
            
            } header: {
                Text("Ingredients")
            }
            
            Section {
                if let linkProvided = dish.recipe, dish.recipe != "" {
                    Link("Check the recipe guide", destination: URL(string: linkProvided)!)
                    
                } else {
                    Text("No recipe guide provided yet.")
                }
            } header: {
                Text("Recipe Guide")
            }
            
        }
        .navigationTitle(dish.name)
        
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DishDetailsView(dish: Dish.example)
    }
}
