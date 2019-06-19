//
//  QuizBuilder.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 18/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

protocol QuizDependency: Dependency {
}

final class QuizComponent: Component<QuizDependency> {
  
}

// MARK: - Builder

protocol QuizBuildable: Buildable {
  func build(withListener listener: QuizListener) -> QuizRouting
}

final class QuizBuilder: Builder<QuizDependency>, QuizBuildable {

  override init(dependency: QuizDependency) {
    super.init(dependency: dependency)
  }

  func build(withListener listener: QuizListener) -> QuizRouting {
    let viewController = QuizViewController()
    let interactor = QuizInteractor(presenter: viewController)
    interactor.listener = listener
    return QuizRouter(interactor: interactor, viewController: viewController)
  }
}
