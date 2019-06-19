//
//  QuizViewController.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 18/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol QuizPresentableListener: class {
  func answerSubmitted(_ answer: String?, forNumbers firstNumber: Int, and secondNumber: Int)
  func quizAborted()
}

final class QuizViewController: UIViewController, QuizPresentable, QuizViewControllable {

  weak var listener: QuizPresentableListener?

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Method is not supported")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

  // MARK: - QuizPresentable Implementation
  func updateViewWhenResult(isCorrect: Bool, withCompletionHandler handler: @escaping () -> ()) {
    let title = isCorrect ? "Yay" : "Oops"
    let message = isCorrect ? "Your answer is correct" : "Your answer is incorrect"
    UIAlertController.showAlert(withTitle: title, message: message, handler: handler, onController: self)
  }

  func updateViewWhenError(_ error: QuizError, withCompletionHandler handler: @escaping () -> ()) {
    UIAlertController.showAlert(withTitle: "Oops", message: error.errorMessage, handler: handler, onController: self)
  }

  func setupView(withNumbers firstNumber: Int, and secondNumber: Int) {
    let descriptionLabel = buildLabel(havingTextColor: .blue,
                                      text: "Lets check how good your multiplication is!")
    view.addSubview(descriptionLabel)
    descriptionLabel.snp.makeConstraints { maker in
      maker.top.equalTo(self.view).offset(80)
      maker.leading.trailing.equalTo(self.view).inset(30)
    }

    let parentStackView = UIStackView()
    parentStackView.axis = .vertical
    parentStackView.spacing = 20
    view.addSubview(parentStackView)

    let questionLabel = buildLabel(havingTextColor: .black,
                                   fontSize: 25,
                                   text: "\(firstNumber) X \(secondNumber) equals?")
    parentStackView.addArrangedSubview(questionLabel)

    let answerField = UITextField()
    answerField.keyboardType = .numberPad
    answerField.borderStyle = UITextField.BorderStyle.line
    answerField.placeholder = answerPlaceholderText
    answerField.textAlignment = .center
    parentStackView.addArrangedSubview(answerField)
    self.answerTextField = answerField
    answerField.snp.makeConstraints { maker in
      maker.height.equalTo(40)
    }

    parentStackView.snp.makeConstraints { maker in
      maker.top.equalTo(descriptionLabel).offset(60)
      maker.leading.trailing.equalTo(self.view).inset(30)
    }

    let submitButton = UIButton()
    view.addSubview(submitButton)
    submitButton.snp.makeConstraints { maker in
      maker.top.equalTo(parentStackView.snp.bottom).offset(20)
      maker.leading.trailing.equalTo(self.view).inset(40)
    }
    submitButton.setTitle(submitButtonTitle, for: .normal)
    submitButton.setTitleColor(UIColor.white, for: .normal)
    submitButton.backgroundColor = UIColor.black
    submitButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.listener?.answerSubmitted(answerField.text, forNumbers: firstNumber, and: secondNumber)
        return
      }).disposed(by: disposeBag)

    let skipButton = UIButton()
    view.addSubview(skipButton)
    skipButton.snp.makeConstraints { maker in
      maker.top.equalTo(submitButton.snp.bottom).offset(20)
      maker.leading.trailing.equalTo(self.view).inset(40)
    }
    skipButton.setTitle(skipButtonTitle, for: .normal)
    skipButton.setTitleColor(UIColor.white, for: .normal)
    skipButton.backgroundColor = UIColor.black
    skipButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.listener?.quizAborted()
        return
      }).disposed(by: disposeBag)
  }

  // MARK: - Private
  private let disposeBag = DisposeBag()
  private let submitButtonTitle = "Submit"
  private let skipButtonTitle = "Skip"
  private let answerPlaceholderText = "Enter your answer here"
  private var answerTextField: UITextField?

  // MARK: - Private helpers
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
    label.numberOfLines = 0
    return label
  }
}
