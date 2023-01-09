//
//  StorageService.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import Foundation
import CoreData

final class StorageService {

    static let shared = StorageService()

    private init() {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "test_auth")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - CRUD

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchUsers() -> [TestUser] {
        var users: [TestUser] = []
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TestUser> = TestUser.fetchRequest()
        do {
            users =  try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return users
    }

    func saveUser(
        withEmail email: String,
        andPassword password: String
    ) {
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(
            forEntityName: Locale.entityName.string,
            in: context
        ) else {
            print("Error while save entity")
            return
        }
        let userObject = TestUser(entity: entity, insertInto: context)
        userObject.email = email
        userObject.password = password
        saveContext()
    }

    func findUserForLogin(
        withEmail email: String,
        andPassword password: String
    ) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Locale.entityName.string)
        fetchRequest.predicate = NSPredicate(format: Locale.predicateEmail.string, email)
        guard
            let users = try? persistentContainer.viewContext.fetch(fetchRequest) as? [TestUser], !users.isEmpty
        else {
            return false
        }

        guard let requiredUser = users.first else {
            return false
        }

        if requiredUser.password == password {
            return true
        } else {
            return false
        }
    }


    func updateUserPassword(
        forEmail email: String,
        newPassword password: String
    ) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Locale.entityName.string)
        fetchRequest.predicate = NSPredicate(format: Locale.predicateEmail.string, email)
        if let users = try? persistentContainer.viewContext.fetch(fetchRequest) as? [TestUser], !users.isEmpty {
            guard let requiredUser = users.first else {
                return false
            }
            requiredUser.setValue(password, forKey: Locale.keyPassword.string)
            try? persistentContainer.viewContext.save()
            return true
        } else {
            return false
        }
    }
}
