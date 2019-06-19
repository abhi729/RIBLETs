//
//  RootInteractor.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
  func routeToLoggedIn(withUserName userName: String)
}

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
}

protocol RootListener: class {
  
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

  weak var router: RootRouting?
  weak var listener: RootListener?

  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  func didLogin(withUserName userName: String) {
    router?.routeToLoggedIn(withUserName: userName)
  }

}
