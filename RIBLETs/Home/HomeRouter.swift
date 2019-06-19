//
//  HomeRouter.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

protocol HomeInteractable: Interactable {
  var router: HomeRouting? { get set }
  var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable { }

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {

  override init(interactor: HomeInteractable, viewController: HomeViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
