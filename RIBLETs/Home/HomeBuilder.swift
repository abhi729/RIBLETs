//
//  HomeBuilder.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

protocol HomeDependency: Dependency {
  var userName: String { get }
  var scoreStream: ScoreStream { get }
}

final class HomeComponent: Component<HomeDependency> {
  fileprivate var userName: String {
    return dependency.userName
  }

  fileprivate var scoreStream: ScoreStream {
    return dependency.scoreStream
  }
}

// MARK: - Builder

protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {

    override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeListener) -> HomeRouting {
        let component = HomeComponent(dependency: dependency)
        let viewController = HomeViewController(userName: component.userName)
        let interactor = HomeInteractor(presenter: viewController, scoreStream: component.scoreStream)
        interactor.listener = listener
        return HomeRouter(interactor: interactor, viewController: viewController)
    }
}
