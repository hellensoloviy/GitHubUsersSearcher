//
//  ThreadWithLock.swift
//  GHUsersList
//
//  Created by Olena Solovii on 31.03.2025.
//

import Foundation

@propertyWrapper
public struct ThreadSafeWithLock<Value> {
    
    private var value: Value
    private let lock: NSLocking
    public var locksOnRead: Bool = false

    public init(
        wrappedValue: Value,
        _ lock: NSLocking = NSLock(),
        locksOnRead: Bool = false)
    {
        self.value = wrappedValue
        self.lock = lock
        self.locksOnRead = locksOnRead
    }

    public var wrappedValue: Value {
        get {
            if locksOnRead {
                return lock.execute { value }
            } else {
                return value
            }
        }
        set { lock.store(newValue, in: &value) }
    }
}
