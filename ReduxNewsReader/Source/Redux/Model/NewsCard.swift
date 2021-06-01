//
//  File.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public struct NewsCard {
    public struct Id: Hashable {
        public let value: String
    }
    public let id: Id
    public let title: String
    public let subtitle: String
    public let source: String
    public let date: Date
    public let body: String
}
