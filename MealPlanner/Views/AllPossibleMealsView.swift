//
//  AllPossibleMealsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct AllPossibleMealsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Here you can see, add, edit or remove all the meals you have in your collection.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                ScrollView {
                    List {
                        ForEach(viewModel.possibleMealsList, id:\.id) { meal in
                            Text(meal.name)
                        }
                    }
                }
            }
            .navigationTitle("All Possible Meals")
            .toolbar {
                Button {
                    viewModel.showAddMealSheet.toggle()
                } label: {
                    Label("Add meal", systemImage: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showAddMealSheet) {
                NavigationView {
                    AddMealView(meal: Meal(id: UUID(), name: "")){newMeal in
                        //
                    }
                }
            }
        }
    }
}

struct AllPossibleMealsView_Previews: PreviewProvider {
    static var previews: some View {
        AllPossibleMealsView()
    }
}
