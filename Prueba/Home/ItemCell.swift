//
//  ItemCell.swift
//  Prueba
//
//  Created by Juan Jose Elias Navarro on 21/08/24.
//

import UIKit

class ItemCell: UITableViewCell {
    
    lazy var lblName: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(lblName)
        
        NSLayoutConstraint.activate([
            lblName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            lblName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            lblName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lblName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
        ])
    }
    
    func config(name: String) {
        lblName.text = String(format: "* %@", name)
    }

}
