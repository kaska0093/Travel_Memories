//
//  DetailViewController.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 12.02.2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var presenter: DetailPresenterOutputProtocol!


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)

        collectionView.register(CustomCell_CV.self,
                                forCellWithReuseIdentifier: String(describing: CustomCell_CV.self))


        setupLayout()
    }
    
    lazy var collectionView: UICollectionView = {
        
        let collectionViewLoyout = UICollectionViewFlowLayout()
        collectionViewLoyout.scrollDirection = .horizontal
        collectionViewLoyout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10) // отступ между секциями
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLoyout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        collectionView.layer.cornerRadius = 20
        collectionView.isPagingEnabled = true // остановка после каждой ячейки
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    

}

extension DetailViewController {
    
    func setupLayout() {
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(20)
        }
    }

}

extension DetailViewController: DetailViewOutputProtocol {
    
    func success() {
        //
    }
    
    func failure() {
        //
    }
    
    
}

//MARK: - UICollectionViewDataSource
extension DetailViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:CustomCell_CV.self),
                                                      for: indexPath) as! CustomCell_CV
        
        cell.configure(image: UIImage(named: "defaultUser"))
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

