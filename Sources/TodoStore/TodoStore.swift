import Foundation
import Combine

/**
 
 `TodoStoreError` enum defines `Error` cases
 
 | Case                       |     Parameters  | Description                               |
 |-----------------------|:-----------------:|------------------------------------|
 | `todoNotFound` |                     | When TodoItem is not present |
 | `todoError`        | `(String)` | Other error with description    |
 
 - Author: Alan Badillo Salas
 
 */
enum TodoStoreError: Error {
    case todoNotFound
    case todoError(description: String)
}

/**
 
 `TodoStore` class is observable and store a list of `TodoItem`
 
 - Author: Alan Badillo Salas
 
 */
public class TodoStore: ObservableObject {
    
    /// List of to-do items
    @Published public var todos: [TodoItem] = []
    
    /**
     
     Default initializer
     
     */
    public init() {
        
    }
    
    /**
     
     `addTodo` make a `TodoItem` and append to `todos` list
     
     - parameters:
        - withTitle: The title of the to-do
     
     */
    public func addTodo(withTitle title: String) -> TodoItem {
        let todo = TodoItem(
            id: UUID(),
            title: title,
            checked: false,
            createAt: Date(),
            updateAt: nil
        )
        
        todos.append(todo)
        
        return todo
    }
    
    /**
     
     Find the `TodoItem` with `id` from `todos` list
     
     - parameters:
        - withId: The `UUID` to find
     
     - returns: `TodoItem`
        item found with `id`
     
     - throws: `TodoStoreError.todoNotFound`
        if `id` is not present in `todos` list
     
     */
    public func getTodo(withId id: UUID) throws -> TodoItem {
        guard let todo = todos.first(where: { todo in
            todo.id == id
        }) else {
            throw TodoStoreError.todoNotFound
        }
        
        return todo
    }
    
    /**
     
     Find the index of `TodoItem` with `id` from `todos` list
     
     - parameters:
        - withId: The `UUID` to find
     
     - returns: `Int`
        index found with `id`
     
     - throws: `TodoStoreError.todoNotFound`
        if `id` is not present in `todos` list
     
     */
    public func getTodoIndex(withId id: UUID) throws -> Int {
        guard let index = todos.firstIndex(where: { todo in
            todo.id == id
        }) else {
            throw TodoStoreError.todoNotFound
        }
        
        return index
    }
    
    /**
     
     Update `TodoItem` with `id` from `todos` list if parameters are not `nil`
     
     - parameters:
        - withId: The `UUID` to find
        - title: Title to update or `nil`
        - checked: If is checked or `nil`
     
     - returns: `TodoItem`
        item updated with `id`
     
     - throws: `TodoStoreError.todoNotFound`
        if `id` is not present in `todos` list
     
     */
    public func editTodo(withId id: UUID, title: String?, checked: Bool? = nil) throws -> TodoItem {
        var todo = try getTodo(withId: id)
        let todoIndex = try getTodoIndex(withId: id)
        
        if let title = title {
            todo.title = title
//            todo.updateAt = Date()
        }
        
        if let checked = checked {
            todo.checked = checked
//            todo.updateAt = Date()
        }
        
        todos[todoIndex] = todo
        
        return todo
    }
    
    /**
     
     Remove `TodoItem` with `id` from `todos` list if exists
     
     - parameters:
        - withId: The `UUID` to find
     
     - returns: `TodoItem`
        item removed with `id`
     
     - throws: `TodoStoreError.todoNotFound`
        if `id` is not present in `todos` list
     
     */
    public func removeTodo(withId id: UUID) throws -> TodoItem {
        let todoIndex = try getTodoIndex(withId: id)
        
        return todos.remove(at: todoIndex)
    }
    
}
