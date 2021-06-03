//
//  NewsLatest.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public struct NewsLatestState {
    public let ids: [NewsList.Id]
    
    public func reduce(action: Action) -> NewsLatestState {
        switch action {
        
        case NewsListAction.newsListByCategory(.history, .loaded(let news, _)):
            let newsIds = news[..<4].map { $0.id }
            return .init(ids: newsIds)
            
        default:
            return self
        }
    }
}

extension NewsLatestState {
    static var initial: NewsLatestState {
        .init(ids: [])
    }
}
