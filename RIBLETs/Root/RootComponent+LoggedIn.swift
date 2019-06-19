//
//  RootComponent+LoggedIn.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import Foundation

extension RootComponent: LoggedInDependency {
  var loggedInViewController: LoggedInViewControllable {
    return rootViewController
  }
}
