//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by lymos on 2023/1/26.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16
    var body: some View {
        switch rating{
        case 1:
            return Text("1")
        case 2:
            return Text("2")
        case 3:
            return Text("3")
        case 4:
            return Text("4")
        default:
            return Text("1")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
