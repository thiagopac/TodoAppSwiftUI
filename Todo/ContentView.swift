//
//  ContentView.swift
//  Todo
//
//  Created by Thiago Castro on 05/03/26.
//


import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var context
    @State private var title: String = ""
    @FetchRequest(sortDescriptors: []) private var todoItems: FetchedResults<TodoItem>
    
    private var isValidForm: Bool {
        !title.isEmptyOrWhitespace
    }
    
    private func saveTodoItem() {
        let todoItem = TodoItem(context: context)
        todoItem.title = title
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        title = ""
    }
    
    private var pendingTodoItems: [TodoItem] {
        todoItems.filter { !$0.isCompleted }
    }
    
    private var completedTodoItems: [TodoItem] {
        todoItems.filter { $0.isCompleted }
    }
    
    private func updateTodoItem(todoItem: TodoItem) {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    private func deleteTodoItem(_ todoItem: TodoItem) {
        context.delete(todoItem)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    if isValidForm {
                        saveTodoItem()
                    }
                }
            
            List {
                Section("Pending") {
                    
                    if pendingTodoItems.isEmpty {
                        ContentUnavailableView("No pending items", systemImage: "tray")
                    } else {
                        ForEach(pendingTodoItems) { pendingTodoItem in
                            TodoCellView(todoItem: pendingTodoItem, onChanged: updateTodoItem)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let item = pendingTodoItems[index]
                                
                                deleteTodoItem(item)
                            }
                        }
                    }
                    
                }
                
                Section("Completed") {
                    
                    if completedTodoItems.isEmpty {
                        ContentUnavailableView("No completed items yet", systemImage: "tray")
                    } else {
                        ForEach(completedTodoItems) { completedTodoItem in
                            TodoCellView(todoItem: completedTodoItem, onChanged: updateTodoItem)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let item = completedTodoItems[index]
                                
                                deleteTodoItem(item)
                            }
                        }
                    }
                    
                    
                }
            }.listStyle(.plain)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Todo")
    }
}

struct TodoCellView: View {
    
    let todoItem: TodoItem
    let onChanged: (TodoItem) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: todoItem.isCompleted ? "checkmark.square" : "square")
                .onTapGesture {
                    todoItem.isCompleted = !todoItem.isCompleted
                    onChanged(todoItem)
                }
            
            if todoItem.isCompleted {
                Text(todoItem.title ?? "")
                    .strikethrough(todoItem.isCompleted)
            } else {
                TextField("", text: Binding(get: {
                    todoItem.title ?? ""
                }, set: { newValue in
                    todoItem.title = newValue
                }))
                .onSubmit {
                    onChanged(todoItem)
                }
            }
            
        }
    }
}

#Preview {
    
    NavigationStack {
        ContentView()
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}
