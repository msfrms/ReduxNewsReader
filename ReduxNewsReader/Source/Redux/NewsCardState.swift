//
//  NewsDetail.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public struct NewsCardFlowState {
    public let request: UUID?
    public let status: Status
}

public struct NewsCardState {
    public let byId: [NewsCard.Id: NewsCardFlowState]
    
    public func reduce(action: Action) -> NewsCardState {
        // TODO: реализовать reduce
        return self
    }
}

extension NewsCardState {
    static var initial: NewsCardState {
        .init(byId: [:])
    }
}
