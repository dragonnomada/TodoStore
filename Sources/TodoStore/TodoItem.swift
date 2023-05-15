//
//  File.swift
//  
//
//  Created by Alan Badillo Salas on 14/05/23.
//

import Foundation

/**
 
 `TodoItem` struct represents an item to retain an information to-do
 
 | Property         | Type           | Editable    |
 |-----------------|--------------|------------|
 | `id`              | `UUID`     | `false` |
 | `title`       | `String` | `true`   |
 | `checked`   | `Bool`     | `true`   |
 | `createAt` | `Date`     | `false` |
 | `updateAt` | `Date?`   | `true`   |
 
 - Author: Alan Badillo Salas
 
 */
public struct TodoItem: Identifiable, Equatable {
    
    public private(set) var id: UUID
    public var title: String
    public var checked: Bool
    public private(set) var createAt: Date
    public var updateAt: Date?
    
    /**
    
     Create a copy of existing `TodoItem`
     
     - parameters:
        - keepId: Keep the same `id` or new `UUID()`
        - withCreation: Keep the same `createAt` date or new `Date()`
        - withUpdating: Keep the same `updateAt` date or `nil`
     
     */
    public func copy(
        keepId: Bool = false,
        withCreation: Bool = false,
        withUpdating: Bool = false
    ) -> TodoItem {
        return TodoItem(
            id: keepId ? id : UUID(),
            title: title,
            checked: checked,
            createAt: withCreation ? createAt : Date(),
            updateAt: withUpdating ? updateAt : nil
        )
    }
    
}
