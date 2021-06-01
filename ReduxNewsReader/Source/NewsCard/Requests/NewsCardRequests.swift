//
//  NewsDetailRequest.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public enum NewsCardRequests {
    public static func detail(
        state: AppState,
        dispatcher: Dispatcher) -> NetworkOperator.Request? {
        
        // TODO: взять из AppState
        let id = ""
        let request = URLRequest(url: URL(string: "https://meduza.io/api/v3/\(id)")!)
        
        return NetworkOperator.Request(
            id: .init(),
            request: request) { data, response, error in
                // TODO: добавить dispatch в AppState
            }
    }
}
