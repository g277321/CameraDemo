//
//  ImagePicker.swift
//  CameraDemo
//
//  Created by PPG on 28.08.22.
//

import Foundation
import SwiftUI

class ImagePickerCoodinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    
    
    init(image: Binding<UIImage?>, isShown: Binding<Bool>){
        _image = image
        _isShown = isShown
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
    [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[
            UIImagePickerController.InfoKey.originalImage
        ] as? UIImage{
            image = uiImage
            isShown = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct ImagePicker: UIViewControllerRepresentable{
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoodinator
    @Binding var isShown: Bool

    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context:
                                UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() ->ImagePicker.Coordinator {
        return ImagePickerCoodinator(image: $image, isShown: $isShown)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) ->
    UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    
    
}
