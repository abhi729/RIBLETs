//
//  LoggedOutInteractor.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting { }

protocol LoggedOutPresentable: Presentable {
  var listener: LoggedOutPresentableListener? { get set }
  
  func showErrorForMissingUserName()
}

protocol LoggedOutListener: class {
  func didLogin(withUserName userName: String)
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
  
  weak var router: LoggedOutRouting?
  weak var listener: LoggedOutListener?
  
  override init(presenter: LoggedOutPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func login(withUserName userName: String?) {
    guard let userName = userName, !userName.isEmpty else {
      return presenter.showErrorForMissingUserName()
    }
    listener?.didLogin(withUserName: userName)
  }
  
}
