//
//  PersistenceController.swift
//  NoteTakingApp_SwiftUiCoreData
//
//  Created by 5. 3 on 29/07/2024.
//

import Foundation
import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error {
                print("Could not load Core Data persistence stores.", error.localizedDescription)
                fatalError()
            }
        }
    }
    
    func saveChanges() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Could not save changes to Core Data.", error.localizedDescription)
            }
        }
    }
    
    func create(title: String, body: String, isFavorite: Bool) {
        let entity = Note(context: container.viewContext)
        
        entity.id = UUID()
        entity.title = title
        entity.body = body
        entity.isFavorite = isFavorite
        entity.createdAt = Date()
        saveChanges()
    }
    
    func read(predicateFormat: String? = nil, fetchLimit: Int? = nil) -> [Note] {
        
        var results: [Note] = []
        let request = NSFetchRequest<Note>(entityName: "Note")
        
        if predicateFormat != nil {
            request.predicate = NSPredicate(format: predicateFormat!)
        }
        if fetchLimit != nil {
            request.fetchLimit = fetchLimit!
        }
        
        do {
            results = try container.viewContext.fetch(request)
        } catch {
            print ("Could not fetch notes from Core Data.")
        }
        
        return results
    }
    
    func update(entity: Note, title: String? = nil, body: String? = nil, isFavorite: Bool? = nil) {
        
        var hasChanges: Bool = false
        
        if title != nil {
            entity.title = title!
            hasChanges = true
        }
        if body != nil {
            entity.body = body!
            hasChanges = true
        }
        if isFavorite != nil {
            entity.isFavorite = isFavorite!
            hasChanges = true
        }
        
        if hasChanges {
            saveChanges()
        }
    }
    
    func delete(_ entity: Note) {
        container.viewContext.delete(entity)
        saveChanges()
    }
}
