//
//  CustomCell_CV.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 12.02.2024.
//

import UIKit

//protocol CollectionViewCellDelegate: AnyObject {
//    func didSelectItem(at index: Int)
//}


class CustomCell_CV: UICollectionViewCell {
    var selectionView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        inizialization()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    weak var delegate: CollectionViewCellDelegate?
//    var index: Int = 0
//    
//    func selectItem() {
//        delegate?.didSelectItem(at: index)
//    }
    

    private let startTrip: UILabel = {
        let label = UILabel()
        return label
    }()
    private let endtrip: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    func configure(startTrip: String, endTrip: String) {
        self.startTrip.text = startTrip
        self.endtrip.text = endTrip
    }
    /// Для установки линии под выбранной ячейкой CollectionView
    /// - Parameter selected: ячейка выбрана или нет
    func setSelected(_ selected: Bool) {
        selectionView.isHidden = !selected
    }
}

private extension CustomCell_CV {
    func inizialization() {
        
        startTrip.translatesAutoresizingMaskIntoConstraints = false
        endtrip.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(startTrip)
        contentView.addSubview(endtrip)
        
        startTrip.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        endtrip.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(startTrip.snp.bottom).offset(5)
        }
    }
}

extension CustomCell_CV {
    
    private func commonInit() {
        selectionView.backgroundColor = .green
        selectionView.isHidden = true
        contentView.addSubview(selectionView)

        selectionView.snp.makeConstraints { (make) in
            make.height.equalTo(3)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(7)
        }
    }
}
