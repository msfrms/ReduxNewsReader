//
//  NewsDetailRequest.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public enum NewsCardRequests {
    
    private struct NewsCardResponse: Decodable {
        struct Source: Decodable {
            let name: String
        }
        
        struct Content: Decodable {
            let body: String
        }
        
        struct Image: Decodable {
            let large_url: String?
        }
        
        struct Root: Decodable {
            let title: String
            let second_title: String
            let source: Source
            let content: Content
            let pub_date: String
            let image: Image?
        }
        
        let root: Root
    }
    
    public static func card(
        state: AppState,
        dispatcher: Dispatcher) -> [NetworkOperator.Request] {

        return state.newsCard.byId.compactMap { id, state  in
            let request = URLRequest(url: URL(string: "https://meduza.io/api/v3/\(id.value)")!)
            return state.request.map { requestId in
                return NetworkOperator.Request(id: requestId, request: request) { data, response, error in
                    let rep = Response<NewsCardResponse>(
                        data: data,
                        response: response,
                        error: error
                    )
                    switch rep {
                    case .success(.some(let r)):
                        let card = NewsCard(
                            id: id,
                            coverUrl: r.root.image
                                .flatMap { $0.large_url }
                                .flatMap { URL(string: "https://meduza.io/\($0)") },
                            title: r.root.title,
                            subtitle: r.root.second_title,
                            source: r.root.source.name,
                            date: {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                return formatter.date(from: r.root.pub_date) ?? Date()
                            }(),
                            body: r.root.content.body
                        )
                            dispatcher.dispatch(action: NewsCardAction.loaded(card))
                        
                    default:
                        dispatcher.dispatch(action: NewsCardAction.failed(id))
                    }
                }
            }
        }
    }
}
