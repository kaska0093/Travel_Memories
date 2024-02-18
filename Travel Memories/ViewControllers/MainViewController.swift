//
//  TestViewController.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 09.02.2024.
//

import UIKit
import PhotosUI
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
        register3DforImageView()
        
        
        let group = DispatchGroup()
        let serialQueue = DispatchQueue(label: "ru.nikita_shestakov_best-queue")
        let workItem1: DispatchWorkItem?
        workItem1 = DispatchWorkItem {
            self.presenter.getUserInfo()
        }
        if let workItem1 {
            serialQueue.async(group: group, execute: workItem1)
            group.notify(queue: DispatchQueue.main) { [self] in
                loadUserInfo()
            }
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        setupView()
//    }
    
    override func viewWillAppear(_ animated: Bool) {

        presenter.getAllCitis()
        tableView.reloadData()
    }
    
    //MARK: - Lazy Property

    lazy var userName = ElementsBuilder.createLabel(withText: "")
    // label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var tableView: UITableView = ElementsBuilder.createMainTableView()
    
    
    //MARK: - Actions
    @objc private func addNewCity() {
        presenter.addButtonPressed(isEditingMode: false, id: nil)
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
    
    
    func setupElements() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")     
    }
}

//MARK: - Layout
private extension MainViewController {
    
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
    
    func loadUserInfo() {
        userName.text = presenter.userAccountInfo?.name
        
        if presenter.userAccountInfo?.image == nil {
            userImage.image = UIImage(named: "2")
        } else {
            userImage.image = presenter.userAccountInfo?.image
        }
    }
    
    func success_Reload_TableView() {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.showDetailPressed(index: indexPath.row)
    }
    
    //MARK: - SwipeActionsConfiguration
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completionHandler) in
            
            if let index = self.presenter.citys?[indexPath.row].id {
                self.presenter.deleteCertainObject(id: index )
            }
        completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Редактировать") { (action, view, completionHandler) in
            let id = self.presenter.citys![indexPath.row].id
            self.presenter.addButtonPressed(isEditingMode: true, id: id)
            completionHandler(true)
        }
        editAction.backgroundColor = .green
        editAction.image = UIImage(systemName: "pencil")
        editAction.title = "Edit"

        let pinAction = UIContextualAction(style: .normal, title: "Закрепить") { (action, view, completionHandler) in
            self.showDatePickerAlert(currentIndex: indexPath.row)
            completionHandler(true)
        }
        pinAction.backgroundColor = .lightGray
        pinAction.image = UIImage(systemName: "pin.fill")

        
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
            
            UIAction(title: "___________", image: UIImage(systemName: "trash")) {_ in
            },
            
            UIAction(title: "get users ", image: UIImage(systemName: "trash")) {_ in
                self.presenter.getUserInfo()
            },
            UIAction(title: "add trip ", image: UIImage(systemName: "trash")) {_ in
                //self.presenter.addTrip()
            }
        ])
        return addMenuItems
    }
}

//MARK: - 3D Touch
extension MainViewController: UIContextMenuInteractionDelegate {
    
    func register3DforImageView() {
        // для обработки 3d
        let interaction = UIContextMenuInteraction(delegate: self)
        userImage.addInteraction(interaction)
        
        // для нормальных нажатий
        userImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        userImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageViewTapped() {
        
        let alertController = UIAlertController(title: "Демонстрация", message: "Простого касания", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - ContextMenuInteraction
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        let outMenuAction1 = UIAction(title: "Test button", image: nil) { _ in }
        let outMenuAction = UIAction(title: "Name change", image: nil) { _ in
            

            
            let alertController = UIAlertController(title: "New name", message: "Enter new name", preferredStyle: .alert)
            
            let saveTask = UIAlertAction(title: "Save", style: .default) { [self] action in
                let textField = (alertController.textFields?.first)!
                textField.placeholder = "New profile name"
                
                if let name = textField.text {
                    self.presenter.saveUserInfo(name: name, image: self.userImage.image)
                }
            }
            alertController.addTextField()
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(saveTask)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        let outMenu = UIMenu(title: "Редактировавние профиля", children: [outMenuAction])
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
               
            let innMenuAction = UIAction(title: "Camera", image: nil) { _ in
                self.choosePhotoSourse(sourse: .camera)
            }
            let innMenuAction1 = UIAction(title: "Gallery", image: nil) { _ in
                self.picker()
            }
            let innMenuAction2 = UIAction(title: "Save To libruary", image: nil) { _ in
                self.saveImageToGallery(imageView: self.userImage)
            }
            let innMenuAction3 = UIAction(title: "Shared photo", image: nil) { _ in
                guard let image = self.userImage.image else {
                    return
                }
                let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                self.present(activityViewController, animated: true, completion: nil)
            }
            
            let inMenu = UIMenu(title: "Photo Edit", children: [innMenuAction,
                                                                        innMenuAction1,
                                                                        innMenuAction2,
                                                                        innMenuAction3])
            
            return UIMenu(title: "Main Menu", children: [outMenu, outMenuAction1, inMenu])
        }
    }
}

//MARK: - LibruarySourse
extension MainViewController: PHPickerViewControllerDelegate {
    //Privacy - Photo Library Usage Description

    func picker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        for item in results {
            item.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                if let image = image as? UIImage {
                    
                    DispatchQueue.main.async {
                        self.presenter.saveUserInfo(name: self.userName.text,
                                                    image: image)
                    }
                }
            }
        }
    }
}

//MARK: - CameraSourse
extension MainViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //Privacy - Camera Usage Description

    func choosePhotoSourse (sourse : UIImagePickerController.SourceType) {

        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        DispatchQueue.main.async {
            self.presenter.saveUserInfo(name: self.userName.text,
                                        image: info[.editedImage] as? UIImage)
        }
        dismiss(animated: true)
    }
}


//MARK: - SaveImageToGallery
extension MainViewController {
    
    func saveImageToGallery(imageView: UIImageView) {
        guard let image = imageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            print("Изображение успешно сохранено в галерее")
        }
    }
}

extension MainViewController {
    
    func showDatePickerAlert(currentIndex: Int) {
        
        let alertController = UIAlertController(title: "Выберите даты", message: nil, preferredStyle: .alert)

        let datePicker1 = UIDatePicker()
        datePicker1.datePickerMode = .date
        alertController.view.addSubview(datePicker1)

        let datePicker2 = UIDatePicker()
        datePicker2.datePickerMode = .date
        alertController.view.addSubview(datePicker2)

        datePicker1.snp.makeConstraints { make in
            make.top.equalTo(alertController.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(alertController.view)
        }

        datePicker2.snp.makeConstraints { make in
            make.top.equalTo(alertController.view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(alertController.view)
        }

        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let selectedDate1 = datePicker1.date
            let selectedDate2 = datePicker2.date
            self.presenter.addTrip(index: currentIndex, startDate: selectedDate1, endDate: selectedDate2)
        }))

        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }

}

