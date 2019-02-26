//
//  DecodeFailable.swift
//  CodableIdeas
//
//  Created by George Marmaridis on 17.01.19.
//  Copyright © 2019 George Marmaridis. All rights reserved.
//

import Foundation

/// Options for customizing `DecodeFailable`'s behavior.
public final class DecodeFailableOptions {
    /// Whether decoding errors are logged to the console. Defaults to `false`.
    public static var logsErrors: Bool = false
    
    /// An optional closure to be called when a decoding error occurs.
    public static var errorClosure: (() -> Void)? = nil
}

/// A value that decoding can fail silently for.
public struct DecodeFailableValue<Value: Decodable>: Decodable {
    public let value: Value?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self.value = try container.decode(Value.self)
        } catch(let error) {
            self.value = nil
            if DecodeFailableOptions.logsErrors {
                print("\n\nError while decoding \(Value.self)")
                print(error)
            }
            DecodeFailableOptions.errorClosure?()
        }
    }
}


/// An array that decoding for individual elements can fail silently for.
public struct DecodeFailableArray<Element: Decodable>: Decodable {
    public let elements: [Element]
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        var elements: [Element] = []
        if let count = container.count {
            elements.reserveCapacity(count)
        }
        
        while !container.isAtEnd {
            if let element = try container.decode(DecodeFailableValue<Element>.self).value {
                elements.append(element)
            }
        }
        
        self.elements = elements
    }
}

// MARK: Collection
extension DecodeFailableArray: Collection {
    public typealias ArrayType = [Element]
    public typealias Index = ArrayType.Index
    public var startIndex: Index { return elements.startIndex }
    public var endIndex: Index { return elements.endIndex }
    public subscript(index: Index) -> ArrayType.Iterator.Element {
        get { return elements[index] }
    }
    public func index(after i: ArrayType.Index) -> ArrayType.Index {
        return elements.index(after: i)
    }
}
