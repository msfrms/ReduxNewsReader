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
    public let page: Int
    public let hasNext: Bool
    public let status: Status
}

public struct NewsListState {
    public let byCategory: [NewsCategory: NewsListFlowState]
    
    public func reduce(action: Action) -> NewsListState {
        switch action {
        case NewsListAction.newsListByCategory(let category, .failed):
            guard let prev = byCategory[category] else {
                return self
            }
            let state = NewsListFlowState(
                ids: [],
                request: prev.request,
                page: prev.page,
                hasNext: prev.hasNext,
                status: .failed
            )
            return .init(byCategory: byCategory + (category, state))
            
        case NewsListAction.newsListByCategory(let category, .loaded(let news, let hasNext)):
            guard let prev = byCategory[category] else {
                return self
            }
            let state = NewsListFlowState(
                ids: prev.ids + news.map { $0.id },
                request: prev.request,
                page: prev.page,
                hasNext: hasNext,
                status: .success
            )
            return .init(byCategory: byCategory + (category, state))
            
        case NewsListAction.newsListByCategory(let category, .start(let page))
                where page == 0:
            let state = NewsListFlowState(
                ids: [],
                request: UUID(),
                page: 0,
                hasNext: true,
                status: .inProgress
            )
            return .init(byCategory: byCategory + (category, state))

        case NewsListAction.newsListByCategory(let category, .start(let page)) where page > 0:
            guard let prev = byCategory[category], prev.hasNext else {
                return self
            }
            let state = NewsListFlowState(
                ids: prev.ids,
                request: UUID(),
                page: prev.page,
                hasNext: prev.hasNext,
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
