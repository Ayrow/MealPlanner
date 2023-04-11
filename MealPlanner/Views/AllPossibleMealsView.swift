//
//  AllPossibleMealsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct AllPossibleMealsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Here you can see, add, edit or remove all the meals you have in your collection.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                ScrollView {
                    List {
                        
                    }
                }
            }
            .navigationTitle("All Possible Meals")
            .toolbar {
                Button {
                    //
                } label: {
                    Label("Add meal", systemImage: "plus")
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
