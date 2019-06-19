//
//  QuizError.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 18/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import Foundation

enum QuizError: Error {
  case answerNotEntered
  case invalidCharacters
  case unknown

  var errorMessage: String {
    switch self {
    case .answerNotEntered:
      return "You have have not answered the question"
    case .invalidCharacters:
      return "You have entered invalid characters"
    case .unknown:
      return "An unknown error occured"
    }
  }
}
