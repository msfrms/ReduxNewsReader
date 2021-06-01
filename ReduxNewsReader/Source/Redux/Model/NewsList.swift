//
//  NewsList.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public struct NewsList {
    public struct Id: Hashable {
        public let value: String
    }
    public let id: Id
    public let coverUrl: URL
    public let title: String
    public let description: String
}
