//
//  NewsCardAction.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 02.06.2021.
//

import Foundation

public enum NewsCardAction: Action {
    case start(NewsCard.Id)
    case failed(NewsCard.Id)
    case loaded(NewsCard)
}
