//
//  ViewController.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 08.02.2024.
//

import UIKit
import PhotosUI
//Privacy - Photo Library Usage Description
//Privacy - Camera Usage Description


class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func libruaryClick(_ sender: Any) {
        self.picker()

    }
    @IBAction func cameraClick(_ sender: Any) {
        self.choosePhotoSourse(soursee: .camera)

    }



}

extension ViewController: PHPickerViewControllerDelegate {
    //MARK: - Libruary

    func picker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 3
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
                    print(image)
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
}


extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //MARK: - Camera
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
            self.imageView.image = info[.editedImage] as? UIImage
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.clipsToBounds = true
        }
        dismiss(animated: true)
    }
}


