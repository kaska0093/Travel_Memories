//
//  AddViewController.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 10.02.2024.
//

import UIKit

class AddViewController: UIViewController {
    
    var presenter: AddPresenterOutputProtocol!

    

//MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "New city"
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
    
    //MARK: - Lazy properties

    lazy var label1 = ElementsBuilder.createLabel(withText: "Город Посещений")
    lazy var label2 = ElementsBuilder.createLabel(withText: "картинка города")
    lazy var imageView = ElementsBuilder.createImageView(withImageName: "defaultUser")
    
}


//MARK: - superView settings
private extension AddViewController {
    
    func setupView() {
        
        addSubViews()
        navigationItemSetup()
        addActions()
        setupElements()
        setupLayout()
    }
    
    

}

//MARK: -  methods of UI elements settings
private extension AddViewController {
    // методы по настройке элементов интерфейса
    func addSubViews() {
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(registerTF)
        view.addSubview(imageView)
    }
    
    func navigationItemSetup() {
        
        let saveAtion = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewCity))
        self.navigationItem.rightBarButtonItems = [saveAtion]
    }
    
    func addActions() {
        //eyeButton.addTarget(self, action: #selector(displayBookMarks), for: .touchUpInside)
    }
    
    func setupElements() {
       // <#statements#>.delegate = self
    }
}

//MARK: - Layout
private extension AddViewController {
    // размещение элементов интерфейса
    
    
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
    func success() {
        //
    }
    
    func failure() {
        //
    }
    
    
}
