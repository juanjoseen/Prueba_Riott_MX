//
//  HomeViewController.swift
//  Prueba
//
//  Created by Juan Jose Elias Navarro on 21/08/24.
//  
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

    var presenter: Home_ViewToPresenterProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - P R E S E N T E R · T O · V I E W
extension HomeViewController: Home_PresenterToViewProtocol {
}
