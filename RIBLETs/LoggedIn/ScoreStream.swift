//
//  ScoreStream.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RxSwift

struct Score {
  let correctAnswers: Int
  let incorrectAnswers: Int
  
  private let pointsPerAnswer = 10
  
  var value: Int {
    return (correctAnswers - incorrectAnswers) * pointsPerAnswer
  }
  
  static func equals(lhs: Score, rhs: Score) -> Bool {
    return (lhs.correctAnswers - lhs.incorrectAnswers) == (rhs.correctAnswers - rhs.incorrectAnswers)
  }
}

protocol ScoreStream: class {
  var score: Observable<Score> { get }
}

protocol MutableScoreStream: ScoreStream {
  func updateScore(forAnswer isCorrect: Bool)
}

class ScoreStreamImpl: MutableScoreStream {
  
  private let variable = Variable<Score>(Score(correctAnswers: 0, incorrectAnswers: 0))
  
  var score: Observable<Score> {
    return variable
      .asObservable()
      .distinctUntilChanged { (lhs: Score, rhs: Score) -> Bool in
        Score.equals(lhs: lhs, rhs: rhs)
    }
  }
  
  func updateScore(forAnswer isCorrect: Bool) {
    let currentScore = variable.value
    let newScore = Score(correctAnswers: currentScore.correctAnswers + (isCorrect ? 1 : 0),
                         incorrectAnswers: currentScore.incorrectAnswers + (isCorrect ? 0 : 1))
    variable.value = newScore
  }
  
}
