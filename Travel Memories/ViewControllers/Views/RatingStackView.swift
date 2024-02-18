//
//  RatingStackView.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 17.02.2024.
//

import UIKit

class RatingControl: UIStackView {
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }


    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Для изменения / редактирования
    var valueChangedHandler: ((Int) -> Void)?

    
    private func setupButtons() {
        for _ in 0..<5 {
            let button = UIButton()
            
            let emptyStarConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
            let filledStarConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
            
            button.setPreferredSymbolConfiguration(emptyStarConfiguration, forImageIn: .normal)
            button.setPreferredSymbolConfiguration(filledStarConfiguration, forImageIn: .selected)
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.setImage(UIImage(systemName: "star.fill"), for: .selected)
            button.setImage(UIImage(systemName: "star.fill"), for: [.highlighted, .selected])
            
            button.adjustsImageSizeForAccessibilityContentSizeCategory = true

            button.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        spacing = 5
    }
    
    @objc func ratingButtonTapped(sender: UIButton) {
        guard let index = ratingButtons.firstIndex(of: sender) else { return }
        
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
            valueChangedHandler?(0)
        } else {
            rating = selectedRating
            valueChangedHandler?(selectedRating)
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
