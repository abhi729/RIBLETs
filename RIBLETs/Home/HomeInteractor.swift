//
//  HomeInteractor.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs
import RxSwift

protocol HomeRouting: ViewableRouting { }

protocol HomePresentable: Presentable {
  var listener: HomePresentableListener? { get set }
  func display(score: Score)
}

protocol HomeListener: class {
  func startQuiz()
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {

  weak var router: HomeRouting?
  weak var listener: HomeListener?

  init(presenter: HomePresentable,
       scoreStream: ScoreStream) {
    self.scoreStream = scoreStream
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    updateScore()
  }

  // MARK: - Private
  private let scoreStream: ScoreStream

  private func updateScore() {
    scoreStream.score
      .subscribe(
        onNext: { (score) in
          self.presenter.display(score: score)
      }
      ).disposeOnDeactivate(interactor: self)
  }

  // MARK: - HomePresentableListener implementation
  func startQuiz() {
    listener?.startQuiz()
  }
}
