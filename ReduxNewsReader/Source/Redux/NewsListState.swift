//
//  NewsList.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public struct NewsListFlowState {
    public let ids: [NewsList.Id]
    public let request: UUID?
    public let status: Status
}

public struct NewsListState {
    public let byCategory: [NewsCategory: NewsListFlowState]
    
    public func reduce(action: Action) -> NewsListState {
        // TODO: реализовать reduce
        return self
    }
}

extension NewsListState {
    static var initial: NewsListState {
        .init(byCategory: [:])
    }
}
