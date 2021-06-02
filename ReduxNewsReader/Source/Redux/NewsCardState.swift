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
        switch action {
        case NewsCardAction.start(let newsId):
            let state = NewsCardFlowState(request: UUID(), status: .inProgress)
            return .init(byId: byId + (newsId, state))

        case NewsCardAction.failed(let newsId):
            let state = NewsCardFlowState(
                request: byId[newsId]?.request,
                status: .failed
            )
            return .init(byId: byId + (newsId, state))
        
        case NewsCardAction.loaded(let news):
            let state = NewsCardFlowState(
                request: byId[news.id]?.request,
                status: .success
            )
            return .init(byId: byId + (news.id, state))
            
        default:
            return self
        }
    }
}

extension NewsCardState {
    static var initial: NewsCardState {
        .init(byId: [:])
    }
}
