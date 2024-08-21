//
//  HomeRouter.swift
//  Prueba
//
//  Created by Juan Jose Elias Navarro on 21/08/24.
//  
//

import Foundation
import UIKit

class HomeRouter {
	
    static func createModule() -> UIViewController {
        
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}

extension HomeRouter: Home_PresenterToRouterProtocol {
    
}
