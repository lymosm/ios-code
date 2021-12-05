//
//  meView.swift
//  test-swift
//
//  Created by lymos on 2021/12/4.
//

import SwiftUI
import CoreImage.CIFilterBuiltins  // qr code 图片类

struct meView: View {
    @State var name = ""
    @State var email = ""
    
    // 声明变量
    let ci_context = CIContext()
    let ci_filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("name", text: $name)
                    .font(.title)
                    .textContentType(.name)
                    .padding(.all)
                TextField("email", text: $email)
                    .font(.title)
                    .textContentType(.emailAddress)
                    .padding([.horizontal, .bottom])
                
                Image(uiImage: genQrcode(from: "\(name)\(email)"))
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 200, height: 200)
                Spacer()
            }
            .navigationBarTitle(Text("我的二维码"), displayMode: .inline)
        }
    }
    
    func genQrcode(from str: String) -> UIImage{
        let data = Data(str.utf8)
        ci_filter.setValue(data, forKey: "inputMessage")
        
        // 创建图像
        if let output_img = ci_filter.outputImage {
            if let cg_img = ci_context.createCGImage(output_img, from: output_img.extent){
                return UIImage(cgImage: cg_img)
            }
        }
        
        return UIImage()
    }
}

struct meView_Previews: PreviewProvider {
    static var previews: some View {
        meView()
    }
}
