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
}

public func reduce(state: AppState, action: Action) -> AppState {
    AppState(
        newsList: state.newsList.reduce(action: action),
        newsLatest: state.newsLatest.reduce(action: action),
        newsCard: state.newsCard.reduce(action: action),
        newsListAll: state.newsListAll.reduce(action: action),
        newsCardAll: state.newsCardAll.reduce(action: action)
    )
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
