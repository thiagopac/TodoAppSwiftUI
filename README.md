# TodoApp

`TodoApp` is a simple iOS app built with SwiftUI for task management, with local persistence using Core Data.

## Purpose

This repository is a compact practical reference to learn:

- SwiftUI + Core Data integration
- Using `@FetchRequest` to display persisted data
- Basic form validation with Swift extensions
- State-driven UI updates

## What this app does

- Creates todo items by title
- Lists tasks in **Pending** and **Completed** sections
- Marks tasks as completed/uncompleted with a tap
- Edits pending task titles inline
- Deletes tasks from both sections
- Persists all changes locally with Core Data

## Main structure

- `Todo/TodoApp.swift`: app entry point and Core Data context injection
- `Todo/Providers/CoreDataProvider.swift`: Core Data stack (`NSPersistentContainer`)
- `Todo/ContentView.swift`: main todo list UI and CRUD actions
- `Todo/Extensions/String+Extensions.swift`: `isEmptyOrWhitespace` helper for form validation
- `TodoModel.xcdatamodeld/`: Core Data model definition

## Data model (Core Data)

- `TodoItem`
  - `title`
  - `isCompleted`

## How to run

1. Open `Todo.xcodeproj` in Xcode.
2. Select an iOS simulator.
3. Run the project with `Cmd + R`.

## Stack

- Swift 6
- SwiftUI
- Core Data

## Note

All data is local (this project does not use API calls).
