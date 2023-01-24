//
//  AddBookView.swift
//  Bookworm
//
//  Created by lymos on 2023/1/23.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var review = ""
    
    let genres = ["a", "b", "c", "d"]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            Form{
                Section{
                    TextField("name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section{
                    Picker("Rating", selection: $rating){
                        ForEach(0..<6){
                            Text("\($0)")
                        }
                    }
                    TextField("Review", text: $review)
                }
                
                Section{
                    Button("Save"){
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        try? moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
