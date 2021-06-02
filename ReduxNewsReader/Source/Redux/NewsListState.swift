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
        switch action {
        case NewsListAction.newsListByCategory(let category, .failed):
            let state = NewsListFlowState(
                ids: [],
                request: byCategory[category]?.request,
                status: .failed
            )
            return .init(byCategory: byCategory + (category, state))
            
        case NewsListAction.newsListByCategory(let category, .loaded(let news)):
            let state = NewsListFlowState(
                ids: news.map { $0.id },
                request: byCategory[category]?.request,
                status: .success
            )
            return .init(byCategory: byCategory + (category, state))
            
        case NewsListAction.newsListByCategory(let category, .start):
            let state = NewsListFlowState(
                ids: [],
                request: UUID(),
                status: .inProgress
            )
            return .init(byCategory: byCategory + (category, state))
            
        default:
            return self
        }
    }
}

extension NewsListState {
    static var initial: NewsListState {
        .init(byCategory: [:])
    }
}
