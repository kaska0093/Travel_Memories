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

    var presenter: MainPresenterOutputProtocol!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getAllCitis()
        tableView.reloadData()
    }
    
    //MARK: - Lazy Property

    lazy var userName = ElementsBuilder.createLabel(withText: "Nikita")
    // label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "defaultUser")
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var tableView: UITableView = ElementsBuilder.createMainTableView()
    
    
    //MARK: - Actions
    @objc private func addNewCity() {
        presenter.addButtonPressed()
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

//MARK: - UI elements settings
private extension MainViewController {
    // методы по настройке элементов интерфейса
    func addSubViews() {
        
        view.addSubview(userName)
        view.addSubview(userImage)
        view.addSubview(tableView)
    }
    
    func addActions() {
        //eyeButton.addTarget(self, action: #selector(displayBookMarks), for: .touchUpInside)
    }
    
    func setupElements() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")     
    }
}

//MARK: - Layout
private extension MainViewController {
    // размещение элементов интерфейса
    
    
    private enum UIConstats {
        static let imageViewTopSpacing = 0.25

    }
    
    func setupLayout() {
        
        userImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(50)
            make.size.width.height.equalTo(100)
            make.centerY.equalTo(view.bounds.height * UIConstats.imageViewTopSpacing)

        }
        userName.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(view.snp_topMargin).inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(userImage.snp.bottom).inset(-80)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}

//MARK: - MainViewOutputProtocol
extension MainViewController: MainViewOutputProtocol {
    func success() {
        presenter.getAllCitis()
        tableView.reloadData()
    }
    
    func failure() {
        //
    }
    
    
}

//MARK: - UITableViewDataSource
extension MainViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.citys?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 1, green: 0, blue: 1, alpha: 0.1)
        cell.layer.cornerRadius = 15

        
        var content = cell.defaultContentConfiguration()
        
        if let imageData = presenter.citys?[indexPath.row].imageOfCity {
            content.image = UIImage(data: imageData as Data)
        }
        content.text = presenter.citys?[indexPath.row].nameOfCity
        content.secondaryText = presenter.citys?[indexPath.row].nameOfCity
        
        content.imageProperties.cornerRadius = cell.frame.size.height / 2
        content.textProperties.color = .red
        
        cell.contentConfiguration = content

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK: - SwipeActionsConfiguration
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completionHandler) in
            
            if let index = self.presenter.citys?[indexPath.row].id {
                self.presenter.deleteCertainObject(id: index )
            }
        completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false // чтобы вызывать свайп только из левой части ячейки
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Редактировать") { (action, view, completionHandler) in
            // Добавьте ваш код для редактирования ячейки здесь
            completionHandler(true)
        }
        let pinAction = UIContextualAction(style: .normal, title: "Закрепить") { (action, view, completionHandler) in
            // Добавьте ваш код для редактирования ячейки здесь
            view.backgroundColor = .blue
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [editAction, pinAction])
        configuration.performsFirstActionWithFullSwipe = false // чтобы вызывать свайп только из левой части ячейки
        
        return configuration
    }
}

extension MainViewController {
    //MARK: - Gradient
    func addGradient(view: UIView, colors: [UIColor], locations: [NSNumber]) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let cgColors = colors.map { $0.cgColor }
        
        gradientLayer.colors = cgColors
        gradientLayer.locations = locations
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: - MenuSettings
    func menuItemAdd() -> UIMenu {
        
        let addMenuItems = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Delete all", image: UIImage(systemName: "trash")) {_ in
                self.presenter.cleanAll()
                self.tableView.reloadData()
            },
            
            UIAction(title: "___ ", image: UIImage(systemName: "trash")) {_ in
                print("")
            },
            
            UIAction(title: "___ ", image: UIImage(systemName: "trash")) {_ in
                print("")
            }
        ])
        return addMenuItems
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



//print(view.frame.size.height)  // 852
//print(view.bounds.size.height)
//print(view.safeAreaLayoutGuide.layoutFrame.height)
