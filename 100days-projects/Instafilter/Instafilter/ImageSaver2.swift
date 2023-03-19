//
//  ImageSaver.swift
//  Instafilter
//
//  Created by lymos on 2023/3/19.
//

import SwiftUI

class ImageSaver2: NSObject{
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
            errorHandler?(error)
        }else{
            successHandler?()
        }
    }
}
