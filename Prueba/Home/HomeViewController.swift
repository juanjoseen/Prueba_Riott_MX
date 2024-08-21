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
    
    var items: [String] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let table: UITableView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        return table
    }()
    
    lazy var txtField: UITextField = {
        let field: UITextField = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .black
        field.delegate = self
        return field
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Prueba"
        setupUI()
    }
    
    func setupUI() {
        
        view.backgroundColor = .secondarySystemBackground
        
        let fondo: UIView = UIView()
        fondo.backgroundColor = .white
        fondo.translatesAutoresizingMaskIntoConstraints = false
        
        let btnSend: UIButton = UIButton()
        btnSend.translatesAutoresizingMaskIntoConstraints = false
        btnSend.setTitle("Add", for: .normal)
        btnSend.backgroundColor = .systemBlue
        btnSend.setTitleColor(.white, for: .normal)
        btnSend.addTarget(self, action: #selector(sendItem), for: .touchUpInside)
        
        let btnClear: UIButton = UIButton()
        btnClear.translatesAutoresizingMaskIntoConstraints = false
        btnClear.backgroundColor = .systemRed
        btnClear.setTitle("Clear items", for: .normal)
        btnClear.setTitleColor(.white, for: .normal)
        btnClear.layer.cornerRadius = 8
        
        btnClear.addTarget(self, action: #selector(clearItems), for: .touchUpInside)
        
        fondo.addSubview(txtField)
        fondo.addSubview(btnSend)
        
        view.addSubview(fondo)
        view.addSubview(tableView)
        view.addSubview(btnClear)
        
        NSLayoutConstraint.activate([
            fondo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            fondo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fondo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            fondo.heightAnchor.constraint(equalToConstant: 46),
            
            txtField.topAnchor.constraint(equalTo: fondo.topAnchor),
            txtField.bottomAnchor.constraint(equalTo: fondo.bottomAnchor),
            txtField.leadingAnchor.constraint(equalTo: fondo.leadingAnchor, constant: 16),
            txtField.trailingAnchor.constraint(equalTo:  btnSend.leadingAnchor, constant: -16),
            
            btnSend.topAnchor.constraint(equalTo: fondo.topAnchor),
            btnSend.bottomAnchor.constraint(equalTo: fondo.bottomAnchor),
            btnSend.trailingAnchor.constraint(equalTo: fondo.trailingAnchor),
            btnSend.widthAnchor.constraint(equalToConstant: 80),
            
            tableView.topAnchor.constraint(equalTo: fondo.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            btnClear.heightAnchor.constraint(equalToConstant: 46),
            btnClear.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnClear.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnClear.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func addItem(_ name: String) {
        items.append(name)
        txtField.text = nil
        txtField.resignFirstResponder()
    }
    
    @objc func sendItem() {
        if let text: String = txtField.text, !text.isEmpty {
            addItem(text)
        }
    }
    
    @objc func clearItems() {
        self.items = []
    }
    
    func editItem(_ index: Int) {
        let alert: UIAlertController = UIAlertController(title: "Edit item", message: nil, preferredStyle: .alert)
        
        let accept: UIAlertAction = UIAlertAction(title: "Accept", style: .default) { action in
            for txt in alert.textFields ?? [] {
                let textField: UITextField = txt
                if let name: String = textField.text {
                    self.items[index] = name
                }
            }
        }
        
        let cancel: UIAlertAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alert.addTextField { textfield in
            textfield.text = self.items[index]
        }
        alert.addAction(accept)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    func deleteItem(_ index: Int) {
        items.remove(at: index)
    }
}

// MARK: - P R E S E N T E R · T O · V I E W
extension HomeViewController: Home_PresenterToViewProtocol {
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text: String = textField.text, !text.isEmpty {
            addItem(text)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ItemCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        let name: String = items[indexPath.row]
        cell.config(name: name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { action, view, completion in
            self.editItem(indexPath.row)
            completion(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            self.deleteItem(indexPath.row)
            completion(true)
        }
        
        editAction.backgroundColor = .systemBlue
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
}
