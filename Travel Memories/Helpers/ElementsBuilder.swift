//
//  UIHelper.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 10.02.2024.
//

import UIKit

class ElementsBuilder {
    
    static func createButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }
    
    static func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    

    static func createMainTableView() -> UITableView {
        
        let tableView = UITableView()
        //table.backgroundColor = .clear
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        let blurEffect = UIBlurEffect(style: .dark) 
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tableView.bounds
        tableView.backgroundView = blurView
        //  рамки по границе
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.red.cgColor
        // отступа между ячейками
        tableView.separatorInset = UIEdgeInsets(top: 5, left: 10, bottom:5, right: 10)
        //  разделитель между ячейками
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.red
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        return tableView
    }
}
