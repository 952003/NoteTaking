//
//  ContentView.swift
//  NoteTakingApp_SwiftUiCoreData
//
//  Created by 5. 3 on 30/07/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: ViewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.notes.count == 0 {
                    Text("No note saved yet")
                        .bold()
                        .foregroundStyle(.secondary)
                } else {
                    List {
                        ForEach(vm.notes) { note in
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(note.title ?? "")
                                            .font(.title3)
                                            .lineLimit(1)
                                            .bold()
                                        
                                        Text(note.createdAt?.asString() ?? "")
                                            .lineLimit(1)
                                    }
                                    
                                    Text((note.body ?? ""))
                                        .lineLimit(1)
                                }
                                Spacer()
                                
                                Image(systemName: note.isFavorite ? "star.fill" : "star")
                                    .onTapGesture {
                                        vm.toggleFav(note: note)
                                    }
                                    .foregroundColor(note.isFavorite ? .yellow : .secondary)
                            }
                            
                            .swipeActions {
                                Button(role: .destructive) {
                                    vm.deleteNote(note: note)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                Button("New") {
                    vm.showAlert = true
                }
                .alert(vm.noteTitle, isPresented: $vm.showAlert, actions: {
                    TextField("Title", text: $vm.noteTitle)
                    TextField("Body", text: $vm.noteBody)
                    Button("Save", action: {
                        vm.createNote()
                        vm.clearStates()
                    })
                    Button("Cancel", role: .cancel, action: { vm.clearStates()})
                }) {
                    Text("Create a new note")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


