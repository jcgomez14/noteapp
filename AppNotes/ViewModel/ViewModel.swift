//
//  ViewModel.swift
//  AppNotes
//
//  Created by Juan Cruz on 12/07/2022.
//

import Foundation
import CoreData
import SwiftUI
import Combine

class viewModel: ObservableObject {
    @Published var notes = ""
    @Published var calendar = Date()
    @Published var show = false
    @Published var update : Notes!
    
    //CoreData
    func saveNote (context: NSManagedObjectContext){
        let newNotes = Notes(context: context)
        newNotes.notes = notes
        newNotes.calendar = calendar

        do {
            try context.save()
            print("Save")
            notes = ""
            calendar = Date()
            show.toggle()
        } catch let error as NSError{
            print("Error Save", error.localizedDescription)
        }
    }
    
    func deleteNote (item: Notes, context : NSManagedObjectContext){
        context.delete(item)
        
        do {
            try context.save()
            print("Delete")
        } catch let error as NSError {
            print("Error Delete", error.localizedDescription)
        }
    }
    
    func sendEditNote(item:Notes) {
        update = item
        notes = item.notes ?? ""
        calendar = item.calendar ?? Date()
        show.toggle()
    }
    
    func editNote(context : NSManagedObjectContext){
        update.notes = notes
        update.calendar = calendar
        
        do {
            try context.save()
            print("Edit")
            notes = ""
            calendar = Date()
            update = nil
            show.toggle()
        } catch let error as NSError {
            print("Error Edit", error.localizedDescription)
        }
        
    }
}
