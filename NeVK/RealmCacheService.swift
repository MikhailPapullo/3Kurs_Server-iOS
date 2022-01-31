//
//  RealmCacheService.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/24/22.
//

import RealmSwift

final class RealmCacheService {

    enum errors: Error {
        case noRealmObject(String)
        case noPrimaryKeys(String)
        case failedToRead(String)
    }
    
    var realm: Realm

    init() {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            self.realm = try Realm(configuration: config)
            print(realm.configuration.fileURL)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func create<T: Object>(_ object: T, completion: (Result<Bool, Error>) -> Void) {
        do {
            realm.beginWrite()
            realm.add(object, update: .modified)
            try realm.commitWrite()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }

    func create<T: Object>(_ objects: [T], completion: (Result<Bool, Error>) -> Void) {
        do {
            realm.beginWrite()
            realm.add(objects, update: .modified)
            try realm.commitWrite()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }

    func read<T: Object>(_ object: T.Type, key: String = "", completion: (Result<T, Error>) -> Void) {

        if let result = realm.object(ofType: T.self, forPrimaryKey: key) {
            completion(.success(result))
        } else {
            completion(.failure(errors.failedToRead("Could not read such object")))
        }
    }

    func read<T: Object>(_ object: T.Type, completion: (Results<T>) -> Void) {

        let result = realm.objects(T.self)
        completion(result)
    }

    func update<T: Object>(_ object: T, completion: (Result<Bool, Error>) -> Void) {

        guard let _ = T.primaryKey() else {
            completion(.failure(errors.noPrimaryKeys("This model does not have a primary key")))
            return
        }

        do {
            realm.beginWrite()
            realm.add(object, update: .modified)
            try realm.commitWrite()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }

    func delete<T: Object>(_ object: T.Type, keyValue: String, completion: (Result<Bool, Error>) -> Void) {

        guard let primaryKey = T.primaryKey() else {
            completion(.failure(errors.noPrimaryKeys("This model does not have a primary key")))
            return
        }

        guard let object = realm.objects(T.self).filter("\(primaryKey) = %@", Int(keyValue)).first else {
            completion(.failure(errors.noRealmObject("There is no such object")))
            return
        }

        do {
            realm.beginWrite()
            realm.delete(object)
            try realm.commitWrite()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }

    func delete<T: Object>(_ object: T.Type, completion: (Result<Bool, Error>) -> Void) {
        let oldData = realm.objects(T.self)

        do {
            realm.beginWrite()
            realm.delete(oldData)
            try realm.commitWrite()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }

    func deleteAll() {
        realm.beginWrite()
        realm.deleteAll()
        try? realm.commitWrite()
    }
}
