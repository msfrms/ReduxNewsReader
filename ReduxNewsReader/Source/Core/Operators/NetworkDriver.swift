//
//  NetworkDriver.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

public class NetworkDriver {
    let networkOperator: NetworkOperator

    public init(`operator`: NetworkOperator) {
        networkOperator = `operator`
    }

    public func observe(state: AppState, dispatcher: Dispatcher) {
        var requests: NetworkOperator.Props = [
            NewsListRequests.latestNews(state: state, dispatcher: dispatcher)
        ].compactMap { $0 }
        
        requests += NewsListRequests.list(state: state, dispatcher: dispatcher)
        requests += NewsCardRequests.card(state: state, dispatcher: dispatcher)
        
        networkOperator.process(props: requests)
    }
}
