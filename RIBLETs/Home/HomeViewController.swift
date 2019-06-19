//
//  HomeViewController.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol HomePresentableListener: class {
  func startQuiz()
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {

  weak var listener: HomePresentableListener?

  init(userName: String) {
    self.userName = userName
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    buildLabels()
    buildStartButton()
  }

  // MARK:- Private
  private let disposeBag = DisposeBag()
  private let userName: String
  private var score: Score?
  private var userNameLabel: UILabel?
  private var correctAnswersLabel: UILabel?
  private var incorrectAnswersLabel: UILabel?
  private var scoreLabel: UILabel?

  private func buildLabels() {
    let nameLabel = buildLabel(havingTextColor: .black,
                               fontSize: 25,
                               text: "Welcome \(userName)")
    self.userNameLabel = nameLabel
    view.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { maker in
      maker.top.equalTo(self.view).offset(80)
      maker.leading.trailing.equalTo(self.view).inset(30)
    }

    let correctAnsLabel = buildLabel(havingTextColor: .green,
                                     text: "Correct Answers: \(score?.correctAnswers ?? 0)")
    self.correctAnswersLabel = correctAnsLabel
    view.addSubview(correctAnsLabel)
    correctAnsLabel.snp.makeConstraints { maker in
      maker.top.equalTo(nameLabel).offset(60)
      maker.leading.trailing.equalTo(self.view).inset(30)
    }

    let incorrectAnsLabel = buildLabel(havingTextColor: .red,
                                       text: "Incorrect Answers: \(score?.incorrectAnswers ?? 0)")
    self.incorrectAnswersLabel = incorrectAnsLabel
    view.addSubview(incorrectAnsLabel)
    incorrectAnsLabel.snp.makeConstraints { maker in
      maker.top.equalTo(correctAnsLabel).offset(30)
      maker.leading.trailing.equalTo(self.view).inset(30)
    }

    let netScoreLabel = buildLabel(havingTextColor: .darkGray,
                                   text: "Score: \(score?.value ?? 0)")
    self.scoreLabel = netScoreLabel
    view.addSubview(netScoreLabel)
    netScoreLabel.snp.makeConstraints { maker in
      maker.top.equalTo(incorrectAnsLabel).offset(30)
      maker.leading.trailing.equalTo(self.view).inset(30)
    }
  }

  private func buildLabel(havingTextColor textColor: UIColor,
                          fontSize: CGFloat = 20,
                          textAlignment: NSTextAlignment = .center,
                          text: String? = nil) -> UILabel {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: fontSize)
    label.textColor = textColor
    label.backgroundColor = .clear
    label.textAlignment = textAlignment
    label.text = text
    return label
  }

  private func buildStartButton() {
    let startButton = UIButton()
    view.addSubview(startButton)
    startButton.snp.makeConstraints { (maker: ConstraintMaker) in
      if let label = scoreLabel {
        maker.top.equalTo(label).offset(60)
      } else {
        maker.center.equalTo(self.view.snp.center)
      }
      maker.leading.trailing.equalTo(self.view).inset(40)
      maker.height.equalTo(40)
    }
    startButton.setTitle("Start Quiz", for: .normal)
    startButton.setTitleColor(UIColor.white, for: .normal)
    startButton.backgroundColor = UIColor.black
    startButton.rx.tap
      .subscribe(
        onNext: { [weak self] in
          self?.listener?.startQuiz()
          return
        }
      )
      .disposed(by: disposeBag)
  }

  // MARK: - HomePresentable implementation
  func display(score: Score) {
    self.score = score
  }
}
