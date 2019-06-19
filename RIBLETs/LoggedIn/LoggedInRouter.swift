//
//  LoggedInRouter.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, HomeListener, QuizListener {
  var router: LoggedInRouting? { get set }
  var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
  func present(viewController: ViewControllable)
  func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
  
  init(interactor: LoggedInInteractable,
       viewController: LoggedInViewControllable,
       homeBuilder: HomeBuildable,
       quizBuilder: QuizBuildable) {
    self.homeBuilder = homeBuilder
    self.quizBuilder = quizBuilder
    self.viewController = viewController
    super.init(interactor: interactor)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    attachHome()
  }
  
  // MARK: - Private
  private let viewController: LoggedInViewControllable
  private let homeBuilder: HomeBuildable
  private let quizBuilder: QuizBuildable
  private var currentChild: ViewableRouting?
  
  // MARK: - LoggedInRouting Implementation
  func cleanupViews() {
    currentChild.map { viewController.dismiss(viewController: $0.viewControllable) }
  }
  
  func routeToHome() {
    detachCurrentChild()
    attachHome()
  }
  
  func routeToQuiz() {
    detachCurrentChild()
    attachQuiz()
  }
  
  // MARK: - Private helpers
  private func detachCurrentChild() {
    currentChild.map {
      detachChild($0)
      viewController.dismiss(viewController: $0.viewControllable)
    }
    currentChild = nil
  }
  
  private func attachHome() {
    let homeRouter = homeBuilder.build(withListener: interactor)
    attachChild(homeRouter)
    currentChild = homeRouter
    viewController.present(viewController: homeRouter.viewControllable)
  }
  
  private func attachQuiz() {
    let quizRouter = quizBuilder.build(withListener: interactor)
    attachChild(quizRouter)
    currentChild = quizRouter
    viewController.present(viewController: quizRouter.viewControllable)
  }
}
