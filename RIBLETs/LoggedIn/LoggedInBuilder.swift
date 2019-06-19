//
//  LoggedInBuilder.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
  var loggedInViewController: LoggedInViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency> {

  let userName: String

  var mutableScoreStream: MutableScoreStream {
    return shared { ScoreStreamImpl() }
  }

  fileprivate var loggedInViewController: LoggedInViewControllable {
    return dependency.loggedInViewController
  }

  init(withDependency dependency: LoggedInDependency, userName: String) {
    self.userName = userName
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
  func build(withListener listener: LoggedInListener, userName: String) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

  override init(dependency: LoggedInDependency) {
    super.init(dependency: dependency)
  }

  func build(withListener listener: LoggedInListener,
             userName: String) -> LoggedInRouting {
    let component = LoggedInComponent(withDependency: dependency, userName: userName)
    let interactor = LoggedInInteractor(mutableScoreStream: component.mutableScoreStream)
    interactor.listener = listener
    let homeBuilder = HomeBuilder(dependency: component)
    let quizBuilder = QuizBuilder(dependency: component)
    return LoggedInRouter(interactor: interactor,
                          viewController: component.loggedInViewController,
                          homeBuilder: homeBuilder,
                          quizBuilder: quizBuilder)
  }
}
