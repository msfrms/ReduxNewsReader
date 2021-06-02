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
        switch action {
        case NewsListAction.latestNews(.start):
            return .init(ids: [], request: UUID(), status: .inProgress)
            
        case NewsListAction.latestNews(.failed):
            return .init(ids: [], request: request, status: .failed)
            
        case NewsListAction.latestNews(.loaded(let news)), NewsListAction.newsListByCategory(.history, .loaded(let news)):
            let newsIds = news[..<4].map { $0.id }
            return .init(ids: newsIds, request: request, status: .success)
            
        default:
            return self
        }
    }
}

extension NewsLatestState {
    static var initial: NewsLatestState {
        .init(ids: [], request: nil, status: .none)
    }
}
