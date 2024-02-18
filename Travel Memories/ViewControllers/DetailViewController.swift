//
//  DetailViewController.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 12.02.2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterOutputProtocol!
    
    //MARK: - override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = presenter.city?.nameOfCity
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Actions
    // currentPlace Add
    @objc func buttonTapped() {
        presenter.changeDataOfTrip(currentPlace: "Cочи парк", rating: nil, comment: nil, typeOfTrip: nil)
        tableView.reloadData()
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        // Метод, который будет вызываться при скрытии клавиатуры
        presenter.changeDataOfTrip(currentPlace: nil, rating: nil, comment: commentView.text, typeOfTrip: nil)
    }
    
    @objc func labelTapped() {
        pickerView.isHidden = false // Показываем UIPickerView при нажатии на label
    }
    
    //MARK: - setup UI
    
    func setupUI() {
        addViews()
        delegateInstall()
        cellRegister()
        setupButton()
        setupRating()
        setupPicker()
        setupLabel()
        setupLayout()
        presenter.setTrip(index: 0)
    }
    
    deinit {
        // Удаляем слушатель уведомления при удалении ViewController'a
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    lazy var tableView: UITableView = ElementsBuilder.createMainTableView()
    lazy var collectionView: UICollectionView = ElementsBuilder.createCollectionView()
    lazy var ratingControl = RatingControl() //FIXME: no that
    lazy var typeOfTripLabel = ElementsBuilder.createLabel(withText: "type of trip")
    lazy var pickerView = UIPickerView()
    let pickerData: [TypeOfTrip] = [.Dont_choose, .Free, .Komandirovka, .Otpusk]
    lazy var commentView = ElementsBuilder.createTextView()
    lazy var addButton = ElementsBuilder.createAddButton()
}

private extension DetailViewController {
    
    func cellRegister() {
        collectionView.register(CustomCell_CV.self,
                                forCellWithReuseIdentifier: String(describing: CustomCell_CV.self))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func delegateInstall() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func addViews() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
        view.addSubview(commentView)
        view.addSubview(addButton)
        view.addSubview(ratingControl)
        view.addSubview(pickerView)
        view.addSubview(typeOfTripLabel)
    }
    
    func setupButton() {
        addButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupRating() {
        ratingControl.alignment = .center
        ratingControl.distribution = .fillEqually
        //MARK: - ratingUpdate
        ratingControl.valueChangedHandler = { intValue in
            self.presenter.changeDataOfTrip(currentPlace: nil, rating: intValue, comment: nil, typeOfTrip: nil)
        }
    }
    
    func setupPicker() {
        pickerView.isHidden = true
        pickerView.backgroundColor = .blue
    }
    
    func setupLabel() {
        typeOfTripLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(labelTapped))
        typeOfTripLabel.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - layout
    func setupLayout() {
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top) // Установка отступа от safeArea сверху
            make.height.equalToSuperview().dividedBy(13) // Установка высоты в 1/13 от высоты супервью
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.size.height.equalTo(250)
            make.bottom.equalToSuperview().inset(30)
        }
        
        ratingControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(5)
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().multipliedBy(0.5)
            make.size.height.equalTo(50)
        }
        typeOfTripLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingControl.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(5)
        }
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(ratingControl.snp.bottom).offset(30)
            make.leading.equalTo(typeOfTripLabel.snp.trailing).offset(20)
            make.size.height.width.equalTo(150)
        }
        commentView.snp.makeConstraints { make in
            make.top.equalTo(typeOfTripLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalTo(tableView.snp.top).inset(-30)
        }
        addButton.snp.makeConstraints { make in
            make.size.width.equalTo(80) //FIXME:  dont't aply
            make.size.height.equalTo(25)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(tableView.snp.top).inset(-5)
        }
    }
}

extension DetailViewController: DetailViewOutputProtocol {
    
    func loadTripInfo() {
        commentView.text = presenter.trip?.tripDescription
        typeOfTripLabel.text = presenter.trip?.typeOfTrip
        ratingControl.rating = presenter.trip?.raiting ?? 0
    }
    
    func success() {
        //
    }
    
    func failure() {
        //
    }
    
    
}

//MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.city?.posts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:CustomCell_CV.self),
                                                      for: indexPath) as! CustomCell_CV
        cell.backgroundColor = .red
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        cell.configure(startTrip: dateFormatter.string(from:(presenter.city?.posts[indexPath.item].firstDate)!),
                       endTrip: dateFormatter.string(from:(presenter.city?.posts[indexPath.item].lastDate)!))
        if indexPath.item == 0 {
            cell.setSelected(true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.setTrip(index: indexPath.item)
        tableView.reloadData()
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCell_CV else { return }
        
        for visibleCell in collectionView.visibleCells {
            if let visibleCell = visibleCell as? CustomCell_CV {
                visibleCell.setSelected(false)
            }
        }
        cell.setSelected(true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 100.0 // Number of items per row and extra margin
        let height = collectionView.bounds.height - 10 // Height minus 10 points
        return CGSize(width: width, height: height)
    }
}
//MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.trip?.currentPlaces.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 1, green: 0, blue: 1, alpha: 0.1)
        cell.layer.cornerRadius = 15
        var content = cell.defaultContentConfiguration()
        content.text = presenter.trip?.currentPlaces[indexPath.row]
        content.textProperties.color = .red
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
//MARK: - UIPickerViewDelegate
extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = pickerData[row].rawValue
        typeOfTripLabel.text = selectedValue
        self.presenter.changeDataOfTrip(currentPlace: nil, rating: nil, comment: nil, typeOfTrip: selectedValue)
        pickerView.isHidden = true
    }
}


