//
//  ContentView.swift
//  Instafilter
//
//  Created by lymos on 2023/3/4.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var image2: Image?
    @State private var showImagePicker = false
    @State private var showImagePciker2 = false
    @State private var inputImage: UIImage?
    @State private var inputImage2: UIImage?
    @State private var filterIntensity = 0.5
    @State private var currentFilter = CIFilter.sepiaTone()
    @State private var currentFilter2: CIFilter = CIFilter.sepiaTone()
    @State private var showFilterSheet = false
    @State private var processImage: UIImage?
    let context = CIContext()
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.secondary)
                        .scaledToFit()
                    // show image
                    if image2 != nil{
                        image2?
                            .resizable()
                            .scaledToFit()
                    }else{
                        Text("Tap to select a picture")
                    }
                }
                .onTapGesture{
                    // select image
                    self.showImagePciker2 = true
                }
                
                HStack{
                    Text("Strong")
                   // Slider(value: $filterIntensity)
                    Slider(value: intensity)
                }.padding(.vertical)
                
                HStack{
                    Button("Change Effect"){
                        self.showFilterSheet = true
                    }
                    Spacer()
                    Button("Save"){
                        guard let processImage = self.processImage else { return }
                        let saver = ImageSaver2()
                        saver.successHandler = {
                            print("save success")
                        }
                        saver.errorHandler = {
                            print("0ops: \($0.localizedDescription) ")
                        }
                        saver.writeToPhotoAlbum(image: processImage)
                    }
                }
                
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showImagePciker2, onDismiss: loadImage2){
                ImagePicker2(image: $inputImage2)
            }
            .actionSheet(isPresented: $showFilterSheet){
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")){
                        self.setFilter(CIFilter.crystallize())
                    },
                    .default(Text("Edges")){
                        self.setFilter(CIFilter.edges())
                    },
                    .default(Text("Vignette")){
                        self.setFilter(CIFilter.vignette())
                    },
                    .cancel()
                ])
            }
            
            
        }
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        
        
        // select and save image
        VStack{
            image?
                .resizable()
                .scaledToFit()
            Button("Select Image"){
                self.showImagePicker = true
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage){
            ImagePicker(img: self.$inputImage)
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
       // UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
        
        let imageSaver = ImageSaver();
        imageSaver.writeToAblum(image: inputImage)
    }
    
    func loadImage2(){
        NSLog("loadImage2")
        guard let inputImage2 = inputImage2 else { return }
        // image2 = Image(uiImage: inputImage2)
        
        let beginImg = CIImage(image: inputImage2)
        currentFilter2.setValue(beginImg, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    // 应用过滤
    func applyProcessing(){
        NSLog("applyProcessing")
        // currentFilter.intensity = Float(filterIntensity)
        // 可换成
        // currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        
        // 再改成更加明显的
        let inputKeys = currentFilter2.inputKeys
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter2.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter2.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter2.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        
        guard let outputImage = currentFilter2.outputImage else { return }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgImage)
            image2 = Image(uiImage: uiImage)
            processImage = uiImage
            NSLog("image2 load")
        }
    }
    
    func setFilter(_ filter: CIFilter){
        NSLog("set filter")
        currentFilter2 = filter
        loadImage2()
    }
}

class ImageSaver: NSObject{
    func writeToAblum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        print("Save Finish")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
