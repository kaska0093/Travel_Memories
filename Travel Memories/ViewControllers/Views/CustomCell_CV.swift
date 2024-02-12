//
//  CustomCell_CV.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 12.02.2024.
//

import UIKit

class CustomCell_CV: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inizialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
//    private let temperatureLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
//    private let hourLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
    
    
    func configure(image: UIImage?) {
        imageView.image = image
    }
}

private extension CustomCell_CV {
    func inizialization() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        //hourLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
//        contentView.addSubview(temperatureLabel)
//        contentView.addSubview(hourLabel)
        
        //hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5).isActive = true
        
//        temperatureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
//        temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: 0).isActive = true

    }
}