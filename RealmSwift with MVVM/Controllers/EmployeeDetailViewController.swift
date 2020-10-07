//
//  ViewController.swift
//  RealmSwift with MVVM
//
//  Created by sarath kumar on 06/10/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//

import UIKit
import RealmSwift

class EmployeeDetailViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UINib(nibName:EmployeeDetailsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EmployeeDetailsTableViewCell.identifier)
        return tableView
    }()
    
    private let noDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "No details available"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        label.isHidden = true
        return label
    }()
    
    private lazy var realmVM: RealmViewModel = {
        let vm = RealmViewModel()
        return vm
    }()
    
    private var employee = [Employee]()
    private var lastSelectedIndex = 0
    private let identifier = "EmployeeDetailCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Employee Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(noDetailLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noDetailLabel.frame = CGRect(x: 10, y: (view.frame.size.height - 100)/2, width: (view.frame.size.width - 20), height: 100)
    }
    
    // MARK: - Custom Methods
    
    private func loadData() {
        
        realmVM.fetchRecords { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
                
            case .success(let employeeData):
                guard !employeeData.isEmpty else {
                    strongSelf.tableView.isHidden = true
                    strongSelf.noDetailLabel.isHidden = false
                    return
                }
                strongSelf.tableView.isHidden = false
                strongSelf.noDetailLabel.isHidden = true
                strongSelf.employee = employeeData
                
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
                
            case .failure(let error):
                strongSelf.tableView.isHidden = true
                strongSelf.noDetailLabel.isHidden = false
                print("unable to load the data: \(error)")
            }
        }
    }
    
    // MARK: - Action Methods
    
    @objc func addBarButtonAction() {
        let addEmployeeVC = AddEmplyeeDetailsViewController()
        addEmployeeVC.title = "Add Employee"
        self.navigationController?.pushViewController(addEmployeeVC, animated: true)
    }
}

extension EmployeeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let empolyeeModel = employee[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeDetailsTableViewCell.identifier, for: indexPath) as! EmployeeDetailsTableViewCell
        cell.configure(model: empolyeeModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employee = self.employee[indexPath.row]
            self.lastSelectedIndex = indexPath.row
            realmVM.DeleteRecords(employee: employee) { [weak self] (success) in
                if success {
                    self?.employee.remove(at: self!.lastSelectedIndex)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.showAlert(titleInput: "Alert", messageInput: "Record deleted successfully..")
                    }
                } else {
                    self?.showAlert(titleInput: "Error", messageInput: "Unable to delete the record..")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

