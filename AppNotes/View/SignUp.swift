//
//  SignUp.swift
//  AppNotes
//
//  Created by Juan Cruz on 12/07/2022.
//

import SwiftUI

struct SignUp: View {
    var body: some View {
        VStack{
            Image("notesapp")
                .resizable()
                .frame(width: 150, height: 150)
                .shadow(color:.cyan, radius: 30)
                .padding()
            Text("How nice to see you again")
                .font(.title)
                .italic()
                .padding(20)
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
