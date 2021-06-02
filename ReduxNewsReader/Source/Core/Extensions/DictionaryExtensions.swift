//
//  DictionaryExtensions.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 02.06.2021.
//

import Foundation

public func + <K, V> (left: [K: V], right: (K, V)) -> [K: V] {

    var dictionary = left
    dictionary[right.0] = right.1
    return dictionary
}
