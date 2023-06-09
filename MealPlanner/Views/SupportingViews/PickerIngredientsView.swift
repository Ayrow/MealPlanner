//
//  PickerIngredientsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 14/04/2023.
//

import SwiftUI

struct PickerIngredientsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ingredientsVM: IngredientsViewModel
    @Binding var ingredientsRecipe: [Ingredient?]
    @State private var tempIngredients: [Ingredient?] = []
    
    var body: some View {
        Form {
            if ingredientsVM.ingredientSearch.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                ForEach(Ingredient.Categories.allCases, id:\.self) { category in
                    Section {
                        ForEach(ingredientsVM.ingredients.filter {$0.category == category}.sorted {$0.name < $1.name}, id:\.self) { ingredient in
                            Button {
                                if let i = tempIngredients.firstIndex(where: {$0 == ingredient}){
                                    tempIngredients.remove(at: i)
                                } else {
                                    tempIngredients.append(ingredient)
                                }
                                
                            } label: {
                                HStack {
                                    Text(ingredient.name)
                                        .foregroundColor(Color.primary)
                                    Spacer()
                                    Image(systemName: tempIngredients.contains(ingredient) ? "checkmark" : "plus.circle")
                                        .foregroundColor(tempIngredients.contains(ingredient) ? Color.green : Color.blue)
                                }
                            }
                            .tag(ingredient as Ingredient?)
                            .font(.title3)
                        }
                        
                    } header: {
                        Text(LocalizedStringKey(category.rawValue))
                    }
                    
                }
            } else {
                if filteredIngredientsList.isEmpty {
                    Text("No matching ingredient")
                } else {
                    ForEach(filteredIngredientsList.sorted {$0!.name < $1!.name}, id:\.self) { ingredient in
                        Button {
                            if let i = tempIngredients.firstIndex(where: {$0 == ingredient}){
                                tempIngredients.remove(at: i)
                            } else {
                                tempIngredients.append(ingredient)
                            }
                            
                        } label: {
                            HStack {
                                Text(ingredient!.name)
                                    .foregroundColor(Color.primary)
                                Spacer()
                                Image(systemName: tempIngredients.contains(ingredient) ? "checkmark" : "plus.circle")
                                    .foregroundColor(tempIngredients.contains(ingredient) ? Color.green : Color.blue)
                            }
                        }
                        .tag(ingredient as Ingredient?)
                        .font(.title3)
                    }
                }


                                
            }
        }
        .navigationTitle("Select the ingredients")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done"){
                    ingredientsRecipe = tempIngredients
                    dismiss()
                }
            }
        }
        .onAppear {
            tempIngredients = ingredientsRecipe
        }
        .searchable(text: $ingredientsVM.ingredientSearch, prompt: "Search Ingredients")
    }
    
    var filteredIngredientsList: [Ingredient?] {
        withAnimation {
            ingredientsVM.ingredients.filter { $0.name.contains(ingredientsVM.ingredientSearch)
            }
        }
    }
    
}

struct PickerIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        PickerIngredientsView(ingredientsRecipe: .constant([Ingredient.example]))
            .environmentObject(IngredientsViewModel())
    }
}
