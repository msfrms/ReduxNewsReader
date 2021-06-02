//
//  File.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public struct NewsListCardAllState {
    public let byId: [NewsCard.Id: NewsCard]
    
    public func reduce(action: Action) -> NewsListCardAllState {
        switch action {
        case NewsCardAction.loaded(let news):
            return .init(byId: byId + (news.id, news))
   
        default:
            return self
        }
    }
}

extension NewsListCardAllState {
    static var initial: NewsListCardAllState {
        .init(byId: [:])
    }
}
