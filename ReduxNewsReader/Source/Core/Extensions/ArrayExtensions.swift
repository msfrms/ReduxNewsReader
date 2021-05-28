//
//  ArrayExtensions.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 28.05.2021.
//

import Foundation

public extension Array {
    func mapWithIndex<T>(_ map: (Element, Int) -> T) -> [T] {
        var items: [T] = []

        for (index, element) in enumerated() {
            items.append(map(element, index))
        }
        
        return items
    }
}
