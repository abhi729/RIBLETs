//
//  LoggedOutBuilder.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

protocol LoggedOutDependency: Dependency { }

final class LoggedOutComponent: Component<LoggedOutDependency> { }

// MARK: - Builder

protocol LoggedOutBuildable: Buildable {
  func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {
  
  override init(dependency: LoggedOutDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
    let viewController = LoggedOutViewController()
    let interactor = LoggedOutInteractor(presenter: viewController)
    interactor.listener = listener
    return LoggedOutRouter(interactor: interactor, viewController: viewController)
  }
}
