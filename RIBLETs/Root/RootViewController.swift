//
//  RootViewController.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class { }

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
  
  weak var listener: RootPresentableListener?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
  }
  
  func present(viewController: ViewControllable) {
    present(viewController.uiviewController, animated: true, completion: nil)
  }
  
  func dismiss(viewController: ViewControllable) {
    dismiss(animated: true, completion: nil)
  }
}
