//
//  NewsListRequest.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public enum NewsListRequests {
    
    private struct ListNewsResponse: Decodable {
        struct DocumentResponse: Decodable {
            let title: String
            let second_title: String
            let share_image_url: String?
        }
        let documents: [String: DocumentResponse]
        let collection: [String]
        let has_next: Bool
        let _count: Int
        
        var newList: [NewsList] {
            collection.compactMap { id -> NewsList? in
                let doc: ListNewsResponse.DocumentResponse? = documents[id]
                return doc.map {
                    NewsList(
                        id: .init(value: id),
                        coverUrl: $0.share_image_url.flatMap { URL(string: $0) },
                        title: $0.title,
                        description: $0.second_title
                    )
                }
            }
        }
    }
    
    public static func list(
        state: AppState,
        dispatcher: Dispatcher) -> [NetworkOperator.Request] {
        
        state.newsList.byCategory.map { category, state in
            let categoryNews = category.rawValue
            let request = URLRequest(url: URL(string: "https://meduza.io/api/v3/search?chrono=\(categoryNews)&locale=ru&page=0&per_page=24")!)
            
            guard let id = state.request else {
                return nil
            }
            return NetworkOperator.Request(id: id,request: request) { data, response, error in
                let response = Response<ListNewsResponse>(
                    data: data,
                    response: response,
                    error: error
                )
                
                switch response {
                case .success(.some(let rep)):
                    dispatcher.dispatch(action: NewsListAction.newsListByCategory(
                                            category,
                                            .loaded(rep.newList, rep.has_next))
                    )

                default:
                    dispatcher.dispatch(action: NewsListAction.newsListByCategory(
                                            category,
                                            .failed)
                    )
                }
                
            }
        }.compactMap { $0 }
    }
}
