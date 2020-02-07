//
//  ExamplePresenter.swift
//  SectionedDataExample
//  Module: Example
//
//  Created by Tabriz Dzhavadov on 12/04/2019.
//  Copyright © 2019 Tabriz Dzhavadov. All rights reserved.
//

import UIKit

protocol ExamplePresenter {
    func viewDidLoad()
    func addItem()
}

class ExamplePresenterImpl: ExamplePresenter {
    fileprivate weak var view: ExampleView?
    fileprivate let router: ExampleRouter

    func viewDidLoad() {

    }

    init(view: ExampleView, router: ExampleRouter) {
        self.view = view
        self.router = router
    }
    
    func addItem() {
        self.view?.show()
    }

}
