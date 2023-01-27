//
//  DetailView.swift
//  Bookworm
//
//  Created by lymos on 2023/1/26.
//

import SwiftUI
import CoreData
struct DetailView: View {
    let book: Book
    @State private var showDeleteAlert = false
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    Image(self.book.genre ?? "Kids")
                       .resizable()
                       .scaledToFit()
                       // .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "KIDS")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                        // .position(x: geometry.size.width - 30)
                }
                Text(self.book.author ?? "Unkonw Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(self.book.review ?? "No Review")
                    .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
            }
            
        }
        .navigationBarTitle(self.book.title ?? "Unkown Title", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showDeleteAlert = true
        }){
            Image(systemName: "trash")
        })
        .alert(isPresented: $showDeleteAlert){
            Alert(title: Text("Delete Book"), message: Text("Are you sure to delete?"), primaryButton: .destructive(Text("Delete")){
                self.deleteBook()
            }, secondaryButton: .cancel())
        }
        
    }
    
    func deleteBook(){
        moc.delete(book)
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book()
        book.title = "aaa"
        return NavigationView{
            DetailView(book: book)
        }
    }
}
