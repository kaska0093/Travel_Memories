//
//  TestViewController.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import UIKit
import SnapKit

//MARK: - MainViewController
final class MainViewController: UIViewController {
    
    //MARK: - Private Property

    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Travel memories"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
        
    }
    override func viewDidLayoutSubviews() {
        setupView()
    }
    
    //MARK: - Lazy Property
    lazy var userName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "defaultUser")
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func addGradient(view: UIView, colors: [UIColor], locations: [NSNumber]) {
        let gradientLayer = CAGradientLayer()
        //gradientLayer.startPoint = .init(x: 0, y: 0)
        //gradientLayer.endPoint = .init(x: -300, y: 0)

        gradientLayer.frame = view.bounds
        let cgColors = colors.map { $0.cgColor }
        
        gradientLayer.colors = cgColors
        gradientLayer.locations = locations
        //gradientLayer.type = .radial
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: - Actions
    @objc private func addNewCity() {
        
    }
    
    //MARK: - MenuSettings
    func menuItemAdd() -> UIMenu {
        
        let addMenuItems = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Statistika", image: UIImage(systemName: "trash")) {_ in
                print("")
            },
            
            UIAction(title: "Add ", image: UIImage(systemName: "trash")) {_ in
                print("")
            },
            
            UIAction(title: "Add ", image: UIImage(systemName: "trash")) {_ in
                print("")
            }
        ])
        return addMenuItems
    }
}

//MARK: - superView settings
private extension MainViewController {
    
    func setupView() {
        addGradient(view: view,
                    colors: [UIColor.red, #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), UIColor.black,  #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),  UIColor.green],
                    locations: [0.0,
                                NSNumber(value: UIConstats.imageViewTopSpacing.self),
                                0.251,
                                0.26,
                                1])
        navigationItemSetup()
        addSubViews()
        addActions()
        setupElements()
        setupLayout()
    }
    
    func navigationItemSetup() {
        
        let menu = UIBarButtonItem(systemItem: .refresh, primaryAction: nil, menu: menuItemAdd())
        let addAtion = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCity))
        
        self.navigationItem.rightBarButtonItems = [addAtion]
        self.navigationItem.leftBarButtonItems = [menu]
    }
    
    
}

//MARK: -  methods of UI elements settings
private extension MainViewController {
    // методы по настройке элементов интерфейса
    func addSubViews() {
        
        view.addSubview(userName)
        view.addSubview(userImage)
        //view.addSubview(colorView)
    }
    
    func addActions() {
        //eyeButton.addTarget(self, action: #selector(displayBookMarks), for: .touchUpInside)
    }
    
    ///  some documentation
    func setupElements() {
       // <#statements#>.delegate = self
        
    }
}

//MARK: - Layout
private extension MainViewController {
    // размещение элементов интерфейса
    
    
    private enum UIConstats {
        static let imageViewTopSpacing = 0.25

    }
    
    
    func setupLayout() {
//        userName.translatesAutoresizingMaskIntoConstraints = false
//        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        userImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.width.height.equalTo(100)
            
            print(view.frame.size.height)  // 852
            print(view.bounds.size.height)
            print(view.safeAreaLayoutGuide.layoutFrame.height)
            
            //make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(y)
            make.top.equalToSuperview().inset(view.bounds.height * UIConstats.imageViewTopSpacing - 50)

        }
    }
    
    
}


//// Создание UI элемента
//let myView = UIView()
//myView.translatesAutoresizingMaskIntoConstraints = false
//myView.backgroundColor = .red
//view.addSubview(myView)
//// Создание NSLayoutConstraint для установки высоты UI элемента
//let heightConstraint = NSLayoutConstraint(item: myView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.2, constant: 0.0)
//view.addConstraint(heightConstraint)
//// Создание NSLayoutConstraint для размещения UI элемента по центру экрана
//let centerXConstraint = NSLayoutConstraint(item: myView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
//view.addConstraint(centerXConstraint)
//// Создание NSLayoutConstraint для размещения UI элемента на расстоянии 0.2 в соотношении с высотой экрана
//let topConstraint = NSLayoutConstraint(item: myView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: view.bounds.height * 0.2)
//view.addConstraint(topConstraint)
