//
//  LoggedInInteractor.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
  func cleanupViews()
  func routeToHome()
  func routeToQuiz()
}

protocol LoggedInListener: class { }

final class LoggedInInteractor: Interactor, LoggedInInteractable {
  
  weak var router: LoggedInRouting?
  weak var listener: LoggedInListener?
  
  private let mutableScoreStream: MutableScoreStream
  
  init(mutableScoreStream: MutableScoreStream) {
    self.mutableScoreStream = mutableScoreStream
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  override func willResignActive() {
    super.willResignActive()
    
    router?.cleanupViews()
  }
  
  // MARK: - HomeListener Implementation
  func startQuiz() {
    router?.routeToQuiz()
  }
  
  // MARK: - QuizListener Implementation
  func quizAborted() {
    router?.routeToHome()
  }
  
  func quizCompleted(withCorrectAnswer isCorrect: Bool) {
    mutableScoreStream.updateScore(forAnswer: isCorrect)
    router?.routeToHome()
  }
}
