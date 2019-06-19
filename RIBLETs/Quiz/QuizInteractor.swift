//
//  QuizInteractor.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 18/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs
import RxSwift

protocol QuizRouting: ViewableRouting { }

protocol QuizPresentable: Presentable {
  var listener: QuizPresentableListener? { get set }
  func setupView(withNumbers firstNumber: Int, and secondNumber: Int)
  func updateViewWhenResult(isCorrect: Bool, withCompletionHandler handler: @escaping () -> ())
  func updateViewWhenError(_ error: QuizError, withCompletionHandler handler: @escaping () -> ())
}

protocol QuizListener: class {
  func quizCompleted(withCorrectAnswer isCorrect: Bool)
  func quizAborted()
}

final class QuizInteractor: PresentableInteractor<QuizPresentable>, QuizInteractable, QuizPresentableListener {

  weak var router: QuizRouting?
  weak var listener: QuizListener?

  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: QuizPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    startQuiz()
  }

  override func willResignActive() {
    super.willResignActive()
  }

  // MARK: - QuizPresentableListener
  func answerSubmitted(_ answer: String?, forNumbers firstNumber: Int, and secondNumber: Int) {
    let validatedAnswer = validateAnswer(answer)
    guard let number = validatedAnswer.value else {
      handle(error: validatedAnswer.error)
      return
    }
    handle(answer: number, whenMultiplying: firstNumber, and: secondNumber)
  }

  func quizAborted() {
    listener?.quizAborted()
  }

  // MARK: - Private helpers
  private func validateAnswer(_ answer: String?) -> (value: Int?, error: QuizError?)  {
    guard let ans = answer else {
      return (nil, QuizError.answerNotEntered)
    }
    guard let answerInInt = Int(ans) else {
      return (nil, QuizError.invalidCharacters)
    }
    return (answerInInt, nil)
  }

  private func handle(error: QuizError?) {
    presenter.updateViewWhenError(error ?? .unknown, withCompletionHandler: {})
  }

  private func handle(answer: Int, whenMultiplying firstNumber: Int, and secondNumber: Int) {
    let isCorrect = checkIfAnswerIsCorrect(answer, whenMultiplying: firstNumber, and: secondNumber)
    presenter.updateViewWhenResult(isCorrect: isCorrect, withCompletionHandler: { [weak self] in
      self?.listener?.quizCompleted(withCorrectAnswer: isCorrect)
    })
  }

  private func checkIfAnswerIsCorrect(_ answer: Int,
                                      whenMultiplying firstNumber: Int, and secondNumber: Int) -> Bool {
    return firstNumber * secondNumber == answer
  }

  private func startQuiz() {
    let firstNumber = generateRandomNumberLessThan100()
    let secondNumber = generateRandomNumberLessThan100()
    presenter.setupView(withNumbers: firstNumber, and: secondNumber)
  }

  private func generateRandomNumberLessThan100() -> Int {
    return Int.random(in: 0..<100)
  }
}
