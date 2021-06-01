//
//  NewsListRequest.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public enum NewsListRequests {
    
    public static func list(
        state: AppState,
        dispatcher: Dispatcher) -> NetworkOperator.Request? {
        
        // TODO: взять из AppState
        let categoryNews = ""
        let request = URLRequest(url: URL(string: "https://meduza.io/api/v3/search?chrono=\(categoryNews)&locale=ru&page=0&per_page=24")!)
        
        return NetworkOperator.Request(
            id: .init(),
            request: request) { data, response, error in
                // TODO: добавить dispatch в AppState
            }
    }
    
    public static func latestNews(
        state: AppState,
        dispatcher: Dispatcher) -> NetworkOperator.Request? {
    
        let request = URLRequest(url: URL(string: "https://meduza.io/api/v3/search?chrono=articles&locale=ru&page=0&per_page=24")!)
        
        return NetworkOperator.Request(
            id: .init(),
            request: request) { data, response, error in
                // TODO: добавить dispatch в AppState
            }
    }
}
