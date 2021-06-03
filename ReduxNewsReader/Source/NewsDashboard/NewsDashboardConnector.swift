//
//  NewsDashboardConnector.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 03.06.2021.
//

import UIKit

public enum NewsDashboardConnector {
    
    public static func connect(store: Store<AppState>, to view: NewsDashboardViewController) {
        view.didLoad = Command {
            store.dispatch(action: NewsListAction.newsListByCategory(.history, .start(0)))
        }
        let unsubscribe = store.subscribe(
            command: CommandWith<AppState> { [weak view] state in
                guard let view = view else {
                    return
                }
                
                view.render(
                    props: .init(
                        header: "Медуза.Новости",
                        categories: .init(items: [
                            .init(
                                title: "Истории",
                                image: Asset.historyBig.image,
                                onTap: .nop
                            ),
                            .init(
                                title: "Игры",
                                image: Asset.gameBig.image,
                                onTap: .nop
                            ),
                            .init(
                                title: "Шапито",
                                image: Asset.shapitoBig.image,
                                onTap: .nop
                            ),
                            .init(
                                title: "Разбор",
                                image: Asset.debriefingBig.image,
                                onTap: .nop
                            )
                        ]),
                        latestNews: {
                            switch state.newsLatest.status {
                            case .inProgress, .none:
                                return .inProgress
                            case .failed:
                                return .empty(
                                    .init(
                                        title: "Упс, что то пошло не так",
                                        onRetry: .nop
                                    )
                                )
                            case .success:
                                let newsProps: [NewsLayout.Props] = state.newsLatest
                                    .ids
                                    .compactMap { state.newsListAll.byId[$0] }
                                    .map { news in
                                        .init(
                                            title: news.title,
                                            subtitle: news.description,
                                            coverUrl: news.coverUrl,
                                            onTap: .nop
                                        )
                                    }
                                return .loaded(
                                    .init(
                                        header: "Последние новости",
                                        more: .nop,
                                        news: newsProps
                                    )
                                )
                            }
                        }()
                    )
                )
            }.observe(queue: .main)
        )
        
        view.deinitCommand = unsubscribe
    }
}
