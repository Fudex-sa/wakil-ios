//
//  SupplierFirstScreenViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISupplierFirstScreenViewController: class {
	var router: ISupplierFirstScreenRouter? { get set }
}

class SupplierFirstScreenViewController: UIViewController {
	var interactor: ISupplierFirstScreenInteractor?
	var router: ISupplierFirstScreenRouter?

    @IBOutlet weak var CityTXT: UITextField!
    
    @IBOutlet weak var cityTable: UITableView!
    var items: [String] = []
    var value: String = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        cityTable.dataSource = self
        cityTable.delegate = self
        CityTXT.text = value
    
    }
    func setUpView(){
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "upArrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        button.frame = CGRect(x: CGFloat(CityTXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        
        CityTXT.leftView = button
        CityTXT.leftViewMode = .always
        
        items.append("hamada")
        items.append("Ahmed")
        items.append("ragab")
        items.append("maohamed")
        items.append("mostafda")
        items.append("hamada")
        cityTable.rowHeight = 50
        let nib = UINib(nibName: "CityCellTableViewCell" , bundle: nil)
        cityTable.register(nib, forCellReuseIdentifier: "hamada")
        
        
    }
    @IBAction func refresh(_ sender: Any) {
        if cityTable.isHidden == true{
            cityTable.isHidden = false
        }
        else{
            cityTable.isHidden = true
        }
    }
    
}

extension SupplierFirstScreenViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hamada", for: indexPath) as! CityCellTableViewCell

cell.city.text = items[indexPath.row]
    return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let val = items[indexPath.row] + " "
        self.value.append(contentsOf: val)
        CityTXT.text = value
        print(value)
        
    }
    
    
}
extension SupplierFirstScreenViewController: ISupplierFirstScreenViewController {
	// do someting...
}

extension SupplierFirstScreenViewController {
	// do someting...
}

extension SupplierFirstScreenViewController {
	// do someting...
}
