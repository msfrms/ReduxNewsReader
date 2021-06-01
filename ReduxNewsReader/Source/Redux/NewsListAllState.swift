//
//  NewsAll.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public struct NewsListAllState {
    public let byId: [NewsList.Id: NewsList]
    
    public func reduce(action: Action) -> NewsListAllState {
        // TODO: реализовать reduce
        return self
    }
}

extension NewsListAllState {
    static var initial: NewsListAllState {
        .init(byId: [:])
    }
}
