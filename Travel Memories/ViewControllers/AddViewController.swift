//
//  AddViewController.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 10.02.2024.
//

import UIKit

class AddViewController: UIViewController {
    
    var presenter: AddPresenterOutputProtocol!
    var isEditingMode: Bool?

//MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        presenter.getMark()
        if isEditingMode == true {
            title = "Edit city"
            registerTF.text = presenter.citys?.nameOfCity
        } else {
            title = "New city"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Private properies
    private let registerTF = CustomTextField(plasehoder: "Enter the name of the city")

    
    //MARK: - Actions
    @objc private func saveNewCity() {
        
        if let text = registerTF.text {
            presenter.saveNewCity(imageOfCity: imageView.image, nameOfCity: text)
        } else {
            print("TextField is empty")
        }
    }
    @objc private func editNewCity() {
        
        if let text = registerTF.text {
            presenter.changeCertainObject(imageOfCity: imageView.image, nameOfCity: text)
        } else {
            print("TextField is empty")
        }
    }
    
    
    //MARK: - Lazy properties

    lazy var label1 = ElementsBuilder.createLabel(withText: "Город Посещений")
    lazy var label2 = ElementsBuilder.createLabel(withText: "картинка города")
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = presenter.citys?.image
        return imageView
    }()
    
}


//MARK: - superView settings
private extension AddViewController {
    
    func setupView() {
        
        addSubViews()
        navigationItemSetup()
        setupLayout()
    }
}

//MARK: -  methods of UI elements settings
private extension AddViewController {

    func addSubViews() {
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(registerTF)
        view.addSubview(imageView)
    }
    
    func navigationItemSetup() {
        
        if isEditingMode == true {
            let editAtion = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editNewCity))
            self.navigationItem.rightBarButtonItems = [editAtion]
        } else {
            let saveAtion = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewCity))
            self.navigationItem.rightBarButtonItems = [saveAtion]
        }
        

    }
}

//MARK: - Layout
private extension AddViewController {
    
    func setupLayout() {
        label1.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalToSuperview().inset(150)

        }
        registerTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(label1.snp.leading)
            make.top.equalTo(label1.snp.bottomMargin).inset(-10)
        }
        
        label2.snp.makeConstraints { make in
            make.leading.equalTo(label1.snp.leading)
            make.top.equalTo(registerTF.snp.bottomMargin).inset(-50)

        }
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.width.height.equalTo(100)
            make.top.equalTo(label2.snp.bottomMargin).inset(-10)
        }

    }
}

extension AddViewController: AddViewOuputProtocol {
    
    func setMark(isEditingMode: Bool?) {
        self.isEditingMode = isEditingMode
    }
    
    func success() {
        //
    }
    
    func failure() {
        //
    }
}
