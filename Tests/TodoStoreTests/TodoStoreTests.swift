import XCTest
@testable import TodoStore

final class TodoStoreTests: XCTestCase {
    
    func testTodoStore() throws {
        
        let todoStore = TodoStore()
        
        let cancellable = todoStore.$todos.sink { todos in
            print(todos)
        }
        
        XCTAssert(todoStore.todos.isEmpty)
        
        let firstTodo = todoStore.addTodo(withTitle: "Hello world")
        
        XCTAssert(todoStore.todos.count == 1)
        XCTAssert(todoStore.todos.first!.title == "Hello world")
        
        XCTAssert(firstTodo == (try todoStore.getTodo(withId: firstTodo.id)))
        
        let secondTodo = todoStore.addTodo(withTitle: "Second Todo")
        
        XCTAssert(todoStore.todos.count == 2)
        XCTAssert(todoStore.todos.last!.title == "Second Todo")
        
        XCTAssert(secondTodo == (try todoStore.getTodo(withId: secondTodo.id)))
        
        let updatedSecondTodo = try todoStore.editTodo(withId: secondTodo.id, title: "Second Todo updated")
        
        XCTAssert(todoStore.todos.count == 2)
        XCTAssert(todoStore.todos.last!.title == "Second Todo updated")
        
        XCTAssert(secondTodo != (try todoStore.getTodo(withId: secondTodo.id)))
        XCTAssert(updatedSecondTodo == (try todoStore.getTodo(withId: secondTodo.id)))
        
        let removedFirstTodo = try todoStore.removeTodo(withId: firstTodo.id)
        
        XCTAssert(todoStore.todos.count == 1)
        XCTAssert(todoStore.todos.first! == updatedSecondTodo)
        XCTAssert(firstTodo == removedFirstTodo)
        
        Thread.sleep(forTimeInterval: 1)
        
        cancellable.cancel()
        
    }
    
}
