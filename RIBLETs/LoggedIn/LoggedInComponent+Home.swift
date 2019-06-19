//
//  LoggedInComponent+Home.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import Foundation

extension LoggedInComponent: HomeDependency {
  var scoreStream: ScoreStream {
    return mutableScoreStream
  }
}

