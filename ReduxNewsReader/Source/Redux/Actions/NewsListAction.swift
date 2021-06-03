//
//  NewsListAction.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 02.06.2021.
//

import Foundation

public enum NewsListAction: Action {
    public typealias PageHasNext = Bool
    public typealias Page = Int
    public enum FetchList {
        case start(Page)
        case failed
        case loaded([NewsList], PageHasNext)
    }
    case newsListByCategory(NewsCategory, FetchList)
}
