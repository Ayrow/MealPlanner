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
    private let timeOfDay = ["Lunch", "Dinner", "Lunch + Dinner"]
    @State private var selectedMealType = "Dinner"
    
    var body: some View {
        NavigationStack {
                Form {
                    ForEach(Days.allCases, id: \.self) { day in
                        Section(day.rawValue) {
                            
                            Picker("Lunch", selection: $selectedMealType) {
                                Text("Meal 1")
                            }
                            .pickerStyle(.navigationLink)
                            
                            Picker("Dinner", selection: $selectedMealType) {
                                Text("Meal 2")
                            }
                            .pickerStyle(.navigationLink)
                        }
                        .headerProminence(.increased)
                    }
                }
                .navigationTitle("Meal Planner")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
