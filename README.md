# ToDo List App

This repository contains a simple ToDo list application built with SwiftUI and SwiftData. The app allows users to add and delete tasks, providing a minimalistic interface for managing tasks. Below is an overview of the code and how the app works.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Code Overview](#code-overview)
  - [CustomButtonStyle](#custombuttonstyle)
  - [ContentView](#contentview)
  - [Task Input Section](#task-input-section)
  - [Task List Section](#task-list-section)
  - [addTask](#addtask)
  - [deleteTask](#deletetask)
- [Contributing](#contributing)

## Features

- Add new tasks with a title and a default subtitle.
- Delete tasks by swiping left on a task.
- Minimalistic and clean user interface.
- SwiftUI and SwiftData integration.

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

Clone the repository:

```bash
git clone https://github.com/your-username/todo-list-app.git
```

Open the project in Xcode:

```bash
cd todo-list-app
open ToDo-List.xcodeproj
```

Build and run the app on the simulator or your device.

## Usage

1. Launch the app.
2. Add a task by typing in the text field and tapping the add button (plus icon).
3. Delete a task by swiping left on the task in the list.

# Code Overview

## CustomButtonStyle
`CustomButtonStyle` is a custom button style that is currently a placeholder for future customization. It ensures that the button's appearance remains consistent throughout the app.

```swift
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
```

## ContentView
`ContentView` is the main view of the app, which consists of the task input section and the task list section.

```swift
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
}
```

## Task Input Section
The task input section contains a `TextField` for entering a new task and a button for adding the task to the list.

```swift
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
```

## Task List Section
The task list section displays the list of tasks and provides the functionality to delete a task.

```swift
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
```

## addTask
The `addTask` function adds a new task to the list.

```swift
private func addTask() {
    guard !newItemText.isEmpty else { return }
    let newTodo = TodoItem(title: newItemText, subtitle: "This is a subtitle.")
    trigger += 1
    context.insert(newTodo)
    newItemText = ""
}
```

## deleteTask
The `deleteTask` function deletes a task at specified indices.

```swift
private func deleteTask(at offsets: IndexSet) {
    offsets.forEach { index in
        context.delete(items[index])
    }
}
```

# Contributing
Contributions are welcome! Please open an issue or submit a pull request for any changes or improvements.
