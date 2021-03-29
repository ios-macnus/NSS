//
//  Collections.swift
//  Plano
//

import Foundation

extension Collection {

    /// Get at index object
    ///
    /// - Parameter index: Index of object
    /// - Returns: Element at index or nil
    func safe(at index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
