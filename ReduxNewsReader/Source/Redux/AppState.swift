//
//  AppState.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public struct AppState {
    public let newsList: NewsListState
    public let newsLatest: NewsLatestState
    public let newsCard: NewsCardState
    public let newsListAll: NewsListAllState
    public let newsCardAll: NewsListCardAllState
    
    public func reduce(action: Action) -> AppState {
        AppState(
            newsList: newsList.reduce(action: action),
            newsLatest: newsLatest.reduce(action: action),
            newsCard: newsCard.reduce(action: action),
            newsListAll: newsListAll.reduce(action: action),
            newsCardAll: newsCardAll.reduce(action: action)
        )
    }
}

extension AppState {
    static var initial: AppState {
        .init(
            newsList: .initial,
            newsLatest: .initial,
            newsCard: .initial,
            newsListAll: .initial,
            newsCardAll: .initial
        )
    }
}
