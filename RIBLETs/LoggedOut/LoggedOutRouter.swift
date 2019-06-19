//
//  LoggedOutRouter.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

protocol LoggedOutInteractable: Interactable {
  var router: LoggedOutRouting? { get set }
  var listener: LoggedOutListener? { get set }
}

protocol LoggedOutViewControllable: ViewControllable { }

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {
  override init(interactor: LoggedOutInteractable, viewController: LoggedOutViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
