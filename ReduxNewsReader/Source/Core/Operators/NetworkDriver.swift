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
        let requests: NetworkOperator.Props = [
            NewsListRequests.list(state: state, dispatcher: dispatcher),
            NewsCardRequests.card(state: state, dispatcher: dispatcher)
        ].flatMap { $0 }
        
        networkOperator.process(props: requests)
    }
}
