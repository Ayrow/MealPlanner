//
//  IngredientsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 13/04/2023.
//

import SwiftUI

struct IngredientsView: View {
    @EnvironmentObject var allIngredients: IngredientsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                    Text(LocalizedStringKey("Here you can see, add, edit or remove all the ingredients you have in your collection."))
                        .multilineTextAlignment(.center)
                        .padding()
                
                    List {
                        ForEach(allIngredients.ingredients, id:\.id) { ingredient in
                            NavigationLink {
                                // MARK: Need a navigation to a Detail View of the Meal
                                NavigationView {
                                    //
                                }
                            } label: {
                                Text(ingredient.name)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    //
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                            }
                            
                        }
                        
                    }
            }
            .navigationTitle("Your Ingredients")
            .toolbar {
                Button {
                    //
                } label: {
                    Label(LocalizedStringKey("Add ingredient"), systemImage: "plus")
                }
            }
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
            .environmentObject(IngredientsViewModel())
    }
}
