//
//  HomePresenter.swift
//  Prueba
//
//  Created by Juan Jose Elias Navarro on 21/08/24.
//  
//

import Foundation

class HomePresenter: Home_ViewToPresenterProtocol {
    
    weak var view: Home_PresenterToViewProtocol?
    var interactor: Home_PresenterToInteractorProtocol?
    var router: Home_PresenterToRouterProtocol?
    
}

// MARK: - I N T E R A C T O R · T O · P R E S E N T E R
extension HomePresenter: Home_InteractorToPresenterProtocol {

}
