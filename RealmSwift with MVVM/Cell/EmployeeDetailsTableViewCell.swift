//
//  EmployeeDetailsTableViewCell.swift
//  RealmSwift with MVVM
//
//  Created by sarath kumar on 07/10/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//

import UIKit

class EmployeeDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "EmployeeDetailsTableViewCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(model: Employee?) {
        name.text = "Employee Name: \(model?.name ?? "")"
        age.text = "Age: \(model?.age ?? "")"
        position.text = "Position: \(model?.position ?? "")"
        phone.text = "Phone: \(model?.phoneNumber ?? "")"
        address.text = "Address: \(model?.address ?? "")"
    }
    
}
