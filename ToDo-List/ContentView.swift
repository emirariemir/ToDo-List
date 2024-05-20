//
//  ContentView.swift
//  ToDo-List
//
//  Created by Emir Arı on 20.05.2024.
//

import SwiftUI
import SwiftData

// Custom button style
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

// Main Content View
struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var newItemText = ""
    @Query private var items: [TodoItem]
    @State private var trigger = 0
    
    var body: some View {
        NavigationView {
            VStack {
                taskInputSection
                taskListSection
            }
            .navigationTitle("ToDo List")
        }
    }
    
    // Task Input Section
    private var taskInputSection: some View {
        HStack {
            TextField("Add a task!", text: $newItemText)
                .textFieldStyle(.roundedBorder)
            
            Button(action: addTask) {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.blue)
                    .frame(height: 30)
                    .symbolEffect(.bounce, value: trigger)
            }
            .buttonStyle(CustomButtonStyle())
        }
        .padding(20)
    }
    
    // Task List Section
    private var taskListSection: some View {
        List {
            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.footnote)
                }
            }
            .onDelete(perform: deleteTask)
        }
        .overlay {
            if items.isEmpty {
                Text("You don't have any task, great!")
                    .opacity(0.5)
            }
        }
    }
    
    // Add a new task
    private func addTask() {
        guard !newItemText.isEmpty else { return }
        let newTodo = TodoItem(title: newItemText, subtitle: "This is a subtitle.")
        trigger += 1
        context.insert(newTodo)
        newItemText = ""
    }
    
    // Delete task at specified indices
    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            context.delete(items[index])
        }
    }
}

// Preview
#Preview {
    ContentView()
}

