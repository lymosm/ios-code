//
//  meView.swift
//  test-swift
//
//  Created by lymos on 2021/12/4.
//

import SwiftUI

struct meView: View {
    @State var name = ""
    @State var email = ""
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
                Spacer()
            }
            .navigationBarTitle(Text("我的"), displayMode: .inline)
        }
    }
    
    func genQrcode(from str: String) -> UIImage{
        return UIImage()
    }
}

struct meView_Previews: PreviewProvider {
    static var previews: some View {
        meView()
    }
}
