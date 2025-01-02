//
//  ViewModel.swift
//  NoteTakingApp_SwiftUiCoreData
//
//  Created by 5. 3 on 30/07/2024.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var notes: [Note] = []
    
    let dataService = PersistenceController.shared
    
    @Published var showAlert: Bool = false
    @Published var noteTitle: String = ""
    @Published var noteBody: String = ""
    @Published var noteIsFav: Bool = false
    
    init() {
        getAllNotes()
    }
    
    func getAllNotes() {
        notes = dataService.read()
    }
    
    func createNote() {
        dataService.create(title: noteTitle, body: noteBody, isFavorite: noteIsFav)
        getAllNotes()
    }
    
    func toggleFav(note: Note) {
        dataService.update(entity: note, isFavorite: !note.isFavorite)
        getAllNotes()
    }
    
    func deleteNote(note: Note) {
        dataService.delete(note)
        getAllNotes()
    }
    
    func clearStates() {
        showAlert = false
        noteTitle = ""
        noteBody = ""
        noteIsFav = false
    }
}
