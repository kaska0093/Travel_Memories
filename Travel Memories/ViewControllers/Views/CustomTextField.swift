//
//  TextField.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 10.02.2024.
//


import UIKit

//MARK: - RegisterTextField
final class CustomTextField: UITextField {
    
    //MARK: - Private Property
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    
    
    //MARK: - Initialization
    init(plasehoder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: plasehoder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Override Methods
    //за размещение теста введенного пользователем
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    //TODO: print something
    //FIXME: error compi
    //за размещение placeHolder
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    //за размещение отредактированного текста
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    //MARK: - Private Methods
    
    /// function to setap TF
    /// - Parameter placeholder: приходит из инициализатора
    private func setupTextField(placeholder: String) {
        textColor = .white
        layer.cornerRadius = 10
        layer.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 15, height: 15)
        
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemCyan])
        font = UIFont.boldSystemFont(ofSize: 18)
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        rightView = UIImageView.init(image: UIImage(systemName: "eye.slash"))
    }
}
