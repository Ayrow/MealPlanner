//
//  AddMealView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct AddMealView: View {
    var body: some View {
        VStack {
            Text("Hello")
        }
        .toolbar {
            Button("Save"){
                //
            }
        }
        .navigationTitle("Add Meal")
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView()
    }
}
