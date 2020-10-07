//
//  AddEmplyeeDetailsViewController.swift
//  RealmSwift with MVVM
//
//  Created by sarath kumar on 06/10/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//

import UIKit

class AddEmplyeeDetailsViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name.."
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your age.."
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let positionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your position.."
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter phone number.."
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter address.."
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.returnKeyType = .done
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.layer.cornerRadius = 12
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var realmVM: RealmViewModel = {
        let vm = RealmViewModel()
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        view.backgroundColor = .gray
        nameTextField.delegate = self
        ageTextField.delegate = self
        positionTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(ageTextField)
        scrollView.addSubview(positionTextField)
        scrollView.addSubview(phoneTextField)
        scrollView.addSubview(addressTextField)
        scrollView.addSubview(registerButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        nameTextField.frame = CGRect(x: 30,
                                     y: 20,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        ageTextField.frame = CGRect(x: 30,
                                    y: nameTextField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        positionTextField.frame = CGRect(x: 30,
                                     y: ageTextField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        phoneTextField.frame = CGRect(x: 30,
                                     y: positionTextField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        addressTextField.frame = CGRect(x: 30,
                                     y: phoneTextField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        registerButton.frame = CGRect(x: 30,
                                      y: addressTextField.bottom + 20,
                                      width: scrollView.width - 60,
                                      height: 52)
        
    }
    
    // MARK: - Action Methods
    
    @objc func registerButtonAction() {
        
        guard let name = nameTextField.text, !name.isEmpty,
            let age = ageTextField.text, !age.isEmpty,
            let position = positionTextField.text, !position.isEmpty,
            let phone = phoneTextField.text, !phone.isEmpty,
            let address = addressTextField.text, !address.isEmpty else {
                self.showAlert(titleInput: "Warning", messageInput: "Please enter the all fields..")
                return
        }
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        positionTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        
        let employee = Employee()
        employee.name = name
        employee.age = age
        employee.position = position
        employee.phoneNumber = phone
        employee.address = address
        
        realmVM.saveRecords(employee: employee) { (success) in
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showAlert(titleInput: "Error", messageInput: "unable to save the records..")
            }
        }
    }

}

extension AddEmplyeeDetailsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.becomeFirstResponder()
        } else if textField == addressTextField {
            self.registerButtonAction()
        }
        
        return true
    }
    
}
