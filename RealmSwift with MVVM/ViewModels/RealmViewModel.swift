//
//  EmployeeViewModel.swift
//  RealmSwift with MVVM
//
//  Created by sarath kumar on 07/10/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RealmViewModel: NSObject {
    
    let realm = try! Realm()
    
    /// DB Helper methods
     
    // Save Records
    func saveRecords(employee: Employee, completion: @escaping (Bool) -> Void) {
        
        do {
            try realm.write {
                realm.add(employee)
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    // Fetch Records
    func fetchRecords(completion: @escaping (Result<[Employee], Error>) -> Void) {
        let employeeDatas = realm.objects(Employee.self)
        if employeeDatas.count > 0 {
            var employeeArray = [Employee]()
            for employee in employeeDatas {
                employeeArray.append(employee)
            }
            completion(.success(employeeArray))
        } else {
            completion(.failure(DatabaseError.faildToFetchData))
        }
    }
    
    // Delete the Record
    func DeleteRecords(employee: Employee, completion: @escaping (Bool) -> Void) {
        do {
            try realm.write {
                realm.delete(employee)
                completion(true)
            }
        } catch  {
            completion(false)
        }
    }
}

public enum DatabaseError: Error {
    case faildToFetchData
}
