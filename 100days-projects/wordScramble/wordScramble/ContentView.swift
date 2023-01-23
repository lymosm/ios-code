//
//  ContentView.swift
//  wordScramble
//
//  Created by lymos on 2022/6/19.
//

import SwiftUI

struct ContentView: View {
    let peopleArr = ["Json", "Woner", "Snor"]
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
        
        NavigationView{
            VStack{
                Section{
                    TextField("Enter your word", text: $newWord, onCommit: addWord)
                        .padding()
                }
                Section{
                    List(usedWords, id: \.self){
                        Image(systemName: "\($0.count).circle")
                        Text($0)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                    }
                }
            }
            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError){
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        
        List{
            Text("aa")
            ForEach(0 ..< 2){
                Text("sss\($0)")
            }
            Text("bb")
        }
        List{
            ForEach(0 ..< 2){
                Text("A \($0)")
            }
        }
        Section(header: Text("Section 1")){
            List{
                Text("aaaa")
                Text("bbb")
            }
            .listStyle(GroupedListStyle())
            List(peopleArr, id: \.self){
                Text($0)
            }
        }
        Section(header: Text("Section 2")){
            List(0 ..< 3) {
                Text("dddd \($0)")
            }
        }
        
        
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func addWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "word used already", message: "Be more original")
            return
        }
        
        guard isReal(word: answer) else{
            wordError(title: "word is not possible", message: "That is`t a real word")
            return
        }
        
        guard isPossible(word: answer) else{
            wordError(title: "word is recognized", message: "You can't just make them up, you known")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let miss = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return miss.location == NSNotFound
    }
    
    func isPossible(word: String) -> Bool{
        var tmpword = rootWord
        for letter in word{
            if let pos = tmpword.firstIndex(of: letter){
                tmpword.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func startGame(){
        if let url = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let words = try? String(contentsOf: url){
                let arr = words.components(separatedBy: "\n")
                rootWord = arr.randomElement() ?? "random-default"
                return
            }
                
        }
        fatalError("Could not load start.txt from bundle!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
