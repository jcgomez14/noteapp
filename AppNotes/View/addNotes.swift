//
//  addNotes.swift
//  AppNotes
//
//  Created by Juan Cruz on 12/07/2022.
//

import SwiftUI


struct addNotes: View {
    
    @ObservedObject var model : viewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(model.update != nil ? "Edit Note" : "Add Note" )
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $model.notes)
            
            Divider()
            Spacer()
            Button(action: {
                if model.update != nil {
                    model.editNote(context: context)
                }else{
                    model.saveNote(context: context)
                }
            },
                   label: {
                        Image(systemName: "plus").foregroundColor(.white)
                        Text("Save").foregroundColor(.white).bold()
                        
                        
            }).padding()
                .background(model.notes == "" ? Color.secondBlue : Color.primaryBlue)
                .cornerRadius(8)
                .disabled(model.notes == "" ? true : false)

        }.padding()
    }
}


