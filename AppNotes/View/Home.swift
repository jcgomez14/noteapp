//
//  Home.swift
//  AppNotes
//
//  Created by Juan Cruz on 12/07/2022.
//

import SwiftUI

struct Home: View {
    @StateObject var model = viewModel()
    @State private var animationButton = false
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [NSSortDescriptor(key: "calendar", ascending: false)]) var results: FetchedResults<Notes>
    
    var body: some View {
        if results.isEmpty {
            VStack{
                Text("Welcome")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.primaryBlue)
                Spacer()
                Text ("This is your room.").font(.headline).foregroundColor(Color.secondWhite)
                Text( "Take notes, write wishes.").font(.subheadline).italic()
                Spacer()
                Button(action: {
            
                withAnimation(.easeInOut(duration: 2).repeatForever()){
                   animationButton.toggle()
                        model.show.toggle()
                    }
                    
                }, label: {
                    Image(systemName:"plus").font(.title2).foregroundColor(.white)
                    Text ("Write").font(.title3).foregroundColor(.white).bold()
                        
                })  .padding()
                    .background(Color.primaryBlue)
                    .cornerRadius(8)
                    .shadow(color: .gray, radius: 5)
                    .scaleEffect(animationButton ? 1.1 : 1)
                    .sheet(isPresented: $model.show, content: {
                        addNotes(model : model)
                    })
            }
        }else{
            
            NavigationView{
                List{
                    ForEach(results){ item in
                        VStack(alignment: .leading){
                            Text(item.notes ?? "No Notes")
                                .font(.title2)
                                .bold()
                            Text(item.calendar ?? Date(), style: .date)
                        }.contextMenu {
                            Button(action: {
                                model.sendEditNote(item: item)
                            },
                                   label: {
                                Text("Edit")
                                Image(systemName: "pencil")
                            })
                            Button(action: {
                                model.deleteNote(item: item, context: context)
                            },
                                   label: {
                                Text("Delete")
                                Image(systemName: "trash")
                            })
                        }
                    }
                }
                .navigationBarTitle("Notes")
                .toolbar {
                    Button(action: {
                        model.show.toggle()
                    },
                           label: {
                        Image(systemName:"plus")
                            .font(.title3)
                            .foregroundColor(Color.primaryBlue)
                    })
                }.sheet(isPresented: $model.show, content: {
                    addNotes(model : model)
                })
            }
            
            
        }
    }
}

