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
        switch action {
        case NewsListAction.newsListByCategory(_, .loaded(let news, _)):
            var ids = byId
            for new in news {
                ids[new.id] = new
            }
            return .init(byId: ids)
        default:
            return self
        }
    }
}

extension NewsListAllState {
    static var initial: NewsListAllState {
        .init(byId: [:])
    }
}
