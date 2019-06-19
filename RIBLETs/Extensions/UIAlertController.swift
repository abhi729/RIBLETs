//
//  UIAlertController.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import UIKit

extension UIAlertController {
  
  static func showAlert(withTitle title: String,
                        message: String,
                        handler: @escaping (() -> ()) = { },
                        onController controller: UIViewController) {
    
    let alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in handler() }
    alertController.addAction(okAction)
    controller.present(alertController, animated: true, completion: nil)
  }
  
}
