//
//  ContentView.swift
//  InstalFilerPrefix
//
//  Created by lymos on 2023/2/24.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0 {
        didSet{
            print("New value is \(blurAmount)")
        }
    }
    @State private var showActionSheet = false
    @State private var backgroundColor = Color.yellow
    
    @State private var image: Image?
    var body: some View {
        
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("222 New value is \(blurAmount)")
            }
        )
        
        VStack{
            image?
                .resizable()
                .scaledToFit()
        }.onAppear(perform: loadImage)
        
        VStack{
            Text("Hello, world!")
                .blur(radius: blurAmount)
            Slider(value: $blurAmount, in: 0...20)
            Slider(value: blur, in: 0...20)
            
            Text("Hi Man")
                .frame(width: 100, height: 100, alignment: .center)
                .background(backgroundColor)
                .onTapGesture{
                    self.showActionSheet = true
                }
                .actionSheet(isPresented: $showActionSheet){
                    ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                                    .default(Text("Red")){
                                        self.backgroundColor = .red
                                    },
                                    .default(Text("green")){
                                        self.backgroundColor = .green
                                    },
                                    .default(Text("Blue")){
                                        self.backgroundColor = .blue
                                    },
                                    .cancel()
                    ])
                }
        }
    }
    
    func loadImage(){
       // image = Image("Example") // show image
        
       guard let inputImage = UIImage(named: "Example")else{ return }
       let beginImage = CIImage(image: inputImage)
    
        let context = CIContext();
        
        // 老照片效果
        // let currentFilter = CIFilter.sepiaTone();
        // currentFilter.inputImage = beginImage
        // currentFilter.intensity = 1
        
        // 像素风滤镜
        // let currentFilter = CIFilter.pixellate();
        // currentFilter.inputImage = beginImage
        // currentFilter.scale = 100;
        
        // 水晶效果
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        currentFilter.radius = 200
        
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
