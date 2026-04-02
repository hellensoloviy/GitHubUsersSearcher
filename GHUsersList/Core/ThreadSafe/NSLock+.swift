//
//  NSLock+.swift
//  GHUsersList
//
//  Created by Olena Solovii on 02.04.2026.
//

import Foundation

extension NSLocking {
    /// Atomically stores new value in object
    @inlinable
    public func store<T>(_ value: T, in object: inout T) {
        mutate(&object, with: { $0 = value })
    }

    /// Atomically mutates object with closure
    @inlinable
    public func mutate<T: AnyObject>(_ object: T, with closure: (T) -> Void) {
       execute { closure(object) }
    }

    /// Atomically mutates object with closure
    @inlinable
    public func mutate<T>(_ object: inout T, with closure: (inout T) -> Void) {
        execute { closure(&object) }
    }

    /// Atomically mutates object with closure
    @inlinable
    public func set<T: AnyObject, Value>(
        _ object: T,
        _ keyPath: ReferenceWritableKeyPath<T, Value>,
        _ value: Value)
    {
        execute { object[keyPath: keyPath] = value }
    }

    /// Atomically mutates object with closure
    @inlinable
    public func set<T, Value>(_ object: inout T, _ keyPath: WritableKeyPath<T, Value>, _ value: Value) {
        execute { object[keyPath: keyPath] = value }
    }

    /// Atomically executes a block of code
    @discardableResult
    @inlinable
    public func execute<T>(code closure: () -> T) -> T {
        lock()
        defer { unlock() }
        return closure()
    }
}
