//
//  AppComponent.swift
//  RIBLETs
//
//  Created by Abhishek Agarwal on 17/06/2019.
//  Copyright © 2019 Grab. All rights reserved.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
  
  init() {
    super.init(dependency: EmptyComponent())
  }
}
