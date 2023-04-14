//
//  PickerDishView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 14/04/2023.
//

import SwiftUI

struct PickerDishView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dishesVM: DishesViewViewModel
    @ObservedObject var viewModel = MainViewViewModel()
    
    @State private var searchText = ""
    
    var onSave: (Dish) -> Void
    var day: MealsPlan.DaysOfWeek
    var mealTime: MealsPlan.Mealtime
    
    
    var body: some View {
        List {
            if filteredDishes.isEmpty {
                Text("No dish found")
            } else {
                ForEach(filteredDishes, id:\.self) { dish in
                    Button {
                        if viewModel.weekMeals[day, mealTime]?.name == dish?.name {
                            viewModel.weekMeals[day, mealTime] = nil
                        } else {
                            onSave(dish!)
                            dismiss()
                        }
                        
                    } label: {
                            if viewModel.weekMeals[day, mealTime]?.name == dish!.name {
                                HStack {
                                    Text(dish!.name).tag(dish as Dish?)
                                        .foregroundColor(.green)
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.green)
                                }
                            } else {
                                Text(dish!.name).tag(dish as Dish?)
                                    .foregroundColor(.primary)
                            }
                        
                        
                       }
                    }
            }
            }
           .navigationTitle("Pick a meal")
           .toolbar {
               ToolbarItem(placement: .navigationBarLeading) {
                   Button("Cancel"){dismiss()}
               
               }
           }
           .searchable(text: $searchText, prompt: "Search for Dish")
        }
    init(day: MealsPlan.DaysOfWeek, mealTime: MealsPlan.Mealtime, onSave: @escaping (Dish) -> Void) {
        self.onSave = onSave
        self.day = day
        self.mealTime = mealTime
    }
    
    var filteredDishes: [Dish?] {
        if searchText.isEmpty {
            return dishesVM.allDishes
        } else {
            return dishesVM.allDishes.filter { $0.name.contains(searchText) }.sorted()
        }
    }
    
    }
    

struct PickerDishView_Previews: PreviewProvider {
    static var previews: some View {
        PickerDishView(day: .Monday, mealTime: .Lunch) {_ in}
            .environmentObject(DishesViewViewModel())
    }
}
