//
//  QuizRouter.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 18/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

protocol QuizInteractable: Interactable {
    var router: QuizRouting? { get set }
    var listener: QuizListener? { get set }
}

protocol QuizViewControllable: ViewControllable { }

final class QuizRouter: ViewableRouter<QuizInteractable, QuizViewControllable>, QuizRouting {
    override init(interactor: QuizInteractable, viewController: QuizViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
