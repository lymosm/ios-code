//
//  ImagePicker.swift
//  Instafilter
//
//  Created by lymos on 2023/3/4.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    @Environment (\.presentationMode) var presentationMode
    @Binding var img: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        var parent: ImagePicker
        init(_ parent: ImagePicker){
            NSLog("Coordinator init")
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            NSLog("select callback")
            if let uiImage = info[.originalImage] as? UIImage{
                parent.img = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator{
        NSLog("image picker show")
        return Coordinator(self)
    }
    
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        // 委托 处理响应
        picker.delegate = context.coordinator
        return picker;
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
    
}
