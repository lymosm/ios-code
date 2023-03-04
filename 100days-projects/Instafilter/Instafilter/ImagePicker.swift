//
//  ImagePicker.swift
//  Instafilter
//
//  Created by lymos on 2023/3/4.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker;
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
    
}
