//
//  NewsListConnector.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 03.06.2021.
//

import Foundation

public enum NewsListConnector {
    
    public static func connect(
        store: Store<AppState>,
        to view: NewsListViewController,
        category: NewsCategory) {

        let newsListLoad = Command {
            store.dispatch(action: NewsListAction.newsListByCategory(category, .start(0)))
        }

        view.didLoad = newsListLoad

        let unsubscribe = store.subscribe(command: CommandWith<AppState> { [weak view] state in
            guard let view = view else {
                return
            }
            guard let newsState = state.newsList.byCategory[category] else {
                view.render(props: .inProgress)
                return
            }
            
            switch newsState.status {
            case .none:
                view.render(props: .inProgress)

            case .inProgress where newsState.ids.isEmpty:
                view.render(props: .inProgress)

            case .failed:
                view.render(
                    props: .empty(
                        .init(
                            title: "Упс, что то пошло не так",
                            description: "Возможно у вас нет интернета",
                            onRetry: .nop
                        )
                    )
                )

            case .success, .inProgress:
                let newsProps: [NewsLayout.Props] = newsState.ids
                    .compactMap { state.newsListAll.byId[$0] }
                    .map { news in
                        .init(
                            title: news.title,
                            subtitle: news.description,
                            coverUrl: news.coverUrl,
                            onTap: NewsCardConnector.openCardBy(
                                newsId: .init(value: news.id.value),
                                store: store,
                                fromViewController: view
                            )
                        )
                    }
                view.render(
                    props: .list(
                        .init(
                            items: newsProps,
                            onFirstPage: Command {
                                store.dispatch(
                                    action: NewsListAction.newsListByCategory(category, .start(0))
                                )
                            },
                            onNextPage: Command {
                                store.dispatch(
                                    action: NewsListAction.newsListByCategory(
                                        category,
                                        .start(newsState.page + 1)
                                    )
                                )
                            }
                        )
                    )
                )
            }
            
            
        }.observe(queue: .main))
        
        view.deinitCommand = unsubscribe
    }
}
