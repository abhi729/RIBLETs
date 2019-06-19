//
//  RootRouter.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
  func present(viewController: ViewControllable)
  func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter <RootInteractable, RootViewControllable>, RootRouting {

  private let loggedOutBuilder: LoggedOutBuildable
  private let loggedInBuilder: LoggedInBuildable
  private var loggedOutRouter: ViewableRouting?

  init(interactor: RootInteractable,
       viewController: RootViewControllable,
       loggedOutBuilder: LoggedOutBuildable,
       loggedInBuilder: LoggedInBuilder) {
    self.loggedOutBuilder = loggedOutBuilder
    self.loggedInBuilder = loggedInBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  override func didLoad() {
    super.didLoad()
    routeToLoggedOut()
  }

  // MARK: - RootRouting Implementation
  func routeToLoggedIn(withUserName userName: String) {
    detachLoggedOutRIB()
    attachLoggedInRIB(withUserName: userName)
  }

  // MARK: - Private helpers
  private func attachLoggedInRIB(withUserName userName: String) {
    let router = loggedInBuilder.build(withListener: interactor, userName: userName)
    attachChild(router)
  }

  private func detachLoggedOutRIB() {
    loggedOutRouter.map {
      detachChild($0)
      viewController.dismiss(viewController: $0.viewControllable)
    }
    loggedOutRouter = nil
  }

  private func routeToLoggedOut() {
    let router = loggedOutBuilder.build(withListener: interactor)
    self.loggedOutRouter = router
    attachChild(router)
    viewController.present(viewController: router.viewControllable)
  }
}
