//
//  HomeProtocols.swift
//  Prueba
//
//  Created by Juan Jose Elias Navarro on 21/08/24.
//  
//

import Foundation
import UIKit

// MARK: VIEW -> PRESENTER
protocol Home_ViewToPresenterProtocol: AnyObject {
	var view: Home_PresenterToViewProtocol? { get set }
	var interactor: Home_PresenterToInteractorProtocol? { get set }
	var router: Home_PresenterToRouterProtocol? { get set }
}

// MARK: PRESENTER -> INTERACTOR
protocol Home_PresenterToInteractorProtocol: AnyObject {
    var presenter: Home_InteractorToPresenterProtocol? { get set }
}

// MARK: INTERACTOR -> PRESENTER
protocol Home_InteractorToPresenterProtocol: AnyObject {
}

// MARK: PRESENTER -> VIEW
protocol Home_PresenterToViewProtocol: AnyObject {
    var presenter: Home_ViewToPresenterProtocol? { get set }
}

// MARK: PRESENTER -> ROUTER
protocol Home_PresenterToRouterProtocol: AnyObject {
}
