//
//  LoggedOutViewController.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import SnapKit
import UIKit

protocol LoggedOutPresentableListener: class {
  func login(withUserName userName: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
  
  weak var listener: LoggedOutPresentableListener?
  
  private let disposeBag = DisposeBag()
  
  private let userNamePlaceholderText = "Please enter your name"
  private let missingUserNameText = "Your name is mandatory"
  private let proceedButtonTitle = "Proceed"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupViews()
  }
  
  func showErrorForMissingUserName() {
    UIAlertController.showAlert(withTitle: "Oops..",
                                message: missingUserNameText,
                                onController: self)
  }
  
  // MARK: - Private helpers
  private func setupViews() {
    let userNameField = buildForm()
    buildProceedButton(withUserNameField: userNameField)
  }
  
  private func buildForm() -> UITextField {
    let userNameField = UITextField()
    userNameField.borderStyle = UITextField.BorderStyle.line
    view.addSubview(userNameField)
    userNameField.placeholder = userNamePlaceholderText
    userNameField.textAlignment = .center
    userNameField.snp.makeConstraints { (maker: ConstraintMaker) in
      maker.top.equalTo(self.view).offset(100)
      maker.leading.trailing.equalTo(self.view).inset(40)
      maker.height.equalTo(40)
    }
    return userNameField
  }
  
  private func buildProceedButton(withUserNameField userNameField: UITextField) {
    let proceedButton = UIButton()
    view.addSubview(proceedButton)
    proceedButton.snp.makeConstraints { (maker: ConstraintMaker) in
      maker.top.equalTo(userNameField.snp.bottom).offset(20)
      maker.left.right.height.equalTo(userNameField)
    }
    proceedButton.setTitle(proceedButtonTitle, for: .normal)
    proceedButton.setTitleColor(UIColor.white, for: .normal)
    proceedButton.backgroundColor = UIColor.black
    proceedButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.listener?.login(withUserName: userNameField.text)
        return
      }).disposed(by: disposeBag)
  }
}
