//
//  NewsLatest.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public struct NewsLatestState {
    public let ids: [NewsList.Id]
    public let request: UUID?
    public let status: Status
    
    public func reduce(action: Action) -> NewsLatestState {
        // TODO: реализовать reduce
        return self
    }
}

extension NewsLatestState {
    static var initial: NewsLatestState {
        .init(ids: [], request: nil, status: .none)
    }
}
