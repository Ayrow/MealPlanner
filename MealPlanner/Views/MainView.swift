//
//  MainView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

enum Days: String, CaseIterable {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    @ObservedObject var recipes = RecipesViewViewModel()
    private let timeOfDay = ["Lunch", "Dinner", "Lunch + Dinner"]
    @State private var selectedMealType = "Dinner"
    
    var body: some View {
        NavigationStack {
                Form {
                    ForEach(MealsPlan.DaysOfWeek.allCases, id: \.self) { day in
                                    Section(day.rawValue) {
                                        ForEach(MealsPlan.MealType.allCases, id: \.self) { mealType in
                                            Picker(mealType.rawValue, selection: $viewModel.weekMeals[day, mealType]) {
                                                Text("Pick a Meal").tag(Optional<Meal>(nil))
                                                ForEach(recipes.allRecipes.sorted()) { meal in
                                                    Text(meal.name).tag(meal as Meal?)
                                                        .foregroundColor(.blue)
                                                   }
                                               }
                                               .pickerStyle(.navigationLink)
                                               
                                           }
                                       }
                                       .headerProminence(.increased)
                                   }
                }
                .onChange(of: viewModel.weekMeals, perform: { _ in
                    viewModel.saveWeekMeals()
                })
                .navigationTitle("Meal Planner")
                .toolbar {
                    Button("Clear All"){
                        viewModel.weekMeals.reset()
                    }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
