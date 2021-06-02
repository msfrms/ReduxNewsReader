//
//  NewsListAction.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 02.06.2021.
//

import Foundation

public enum NewsListAction: Action {
    public enum FetchList {
        case start
        case failed
        case loaded([NewsList])
    }
    case latestNews(FetchList)
    case newsListByCategory(NewsCategory, FetchList)
}
