//
//  Employee.swift
//  RealmSwift with MVVM
//
//  Created by sarath kumar on 06/10/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//

import Foundation
import RealmSwift

class Employee: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = ""
    @objc dynamic var position = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var address = ""
}
