//
//  ViewController.swift
//  Travel Memories
//
//  Created by Nikita Shestakov on 08.02.2024.
//

import UIKit
import PhotosUI


class ViewController: UIViewController {

    @IBAction func sharedPhoto(_ sender: UIButton) {
        //Privacy - Photo Library Additions Usage Description
        guard let image = imageView.image else {
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        present(activityViewController, animated: true, completion: nil)
    }

    
    @IBAction func saveTolibruary(_ sender: UIButton) {
        saveImageToGallery(imageView: imageView)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func libruaryClick(_ sender: Any) {
        self.picker()
    }
    
    @IBAction func cameraClick(_ sender: Any) {
        self.choosePhotoSourse(sourse: .camera)
    }
    
    func saveImageToGallery(imageView: UIImageView) {
        guard let image = imageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Обрабатываем ошибку сохранения
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            // Изображение успешно сохранено
            print("Изображение успешно сохранено в галерее")
        }
    }




}

extension ViewController: PHPickerViewControllerDelegate {
    //MARK: - Libruary
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
            self.imageView.image = info[.editedImage] as? UIImage
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.clipsToBounds = true
        }
        dismiss(animated: true)
    }
}



