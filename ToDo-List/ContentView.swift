//
//  ContentView.swift
//  ToDo-List
//
//  Created by Emir Arı on 20.05.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @State var newItemText = ""
    
    @Query var items: [TodoItem]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add a task!", text: $newItemText)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        guard !newItemText.isEmpty else { return }
                        let newTodo = TodoItem(title: newItemText, subtitle: "This is a subtitle.")
                        context.insert(newTodo)
                        newItemText = ""
                    }, label: {
                        Image(systemName: "plus.app.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                    })
                }
                .padding(20)
                
                List {
                    ForEach(items) { item in
                        Text(item.title)
                            .font(.headline)
                        Text(item.subtitle)
                            .font(.footnote)
                    }
                }
                .overlay {
                    if items.isEmpty {
                        Text("You don't have any task, great!")
                            .opacity(0.5)
                    }
                }
            }
            .navigationTitle("ToDo List")
            
        }
    }
}

#Preview {
    ContentView()
}
