//
//  Cache.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import Foundation

public protocol Cachable {

    func updateCountLimit(count: Int)
}

final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()

    func updateCountLimit(count: Int)  {
        wrapped.countLimit = count
        wrapped.evictsObjectsWithDiscardedContent = true
    }

    func updateTotalCost(costLimit: Int) {
        wrapped.totalCostLimit = costLimit
    }

    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    func value(forKey key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key))
        return entry?.value
    }

    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }

    func removeAllValues() {
        wrapped.removeAllObjects()
    }
}

private extension Cache {

    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
}

private extension Cache {

    final class Entry {
        let value: Value

        init(value: Value) {
            self.value = value
        }
    }
}

extension Cache {

    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                return removeValue(forKey: key)
            }
            insert(value, forKey: key)
        }
    }
}
