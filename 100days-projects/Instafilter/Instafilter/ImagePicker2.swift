//
//  ImagePicker2.swift
//  Instafilter
//
//  Created by lymos on 2023/3/18.
//

import SwiftUI

struct ImagePicker2: UIViewControllerRepresentable{
    
   // typealias UIViewControllerType = UIImagePickerController
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker2

        init(_ parent: ImagePicker2) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
            if let uiImage = info[.originalImage] as? UIImage{
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator{
        Coordinator(self)
    }
    
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker2>) -> UIImagePickerController{
        let picker = UIImagePickerController();
        picker.delegate = context.coordinator
        return picker;
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker2>){
        
    }
    
    
}
