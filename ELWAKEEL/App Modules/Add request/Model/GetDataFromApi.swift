//
//  GetDataFromApi.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/1/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import Foundation
import RSSelectionMenu
import LocalizationFramework

class formatData{
    var selectedOrgName: [String] = [String]()
    var organizationName: [String] = [String]()
    var selectedOrgId: [Int] = [Int]()
    var selected_Country_ID: Int = Int()
    var seleted_City_ID: Int = Int()
    var seleted_organization_ID: Int = Int()
    var type = ""
    var cities = [addrequestModel.Organization]()
    var interactor = getCities()
    var provementsEmails: [String] = [String(Localization.email2), String(Localization.Registered_Mail),String(Localization.Excellent_email)]
    var selectedEmails: [String] = [String]()
    var selectedEmail = ""
    var selected_Conutry_Name = ""
    var selected_City_Name = ""
    var selected_organization_Name = ""
    var selected_Email_Name = ""
    var view: addrequestViewController?
    init() {
        
    }
    func getOrganization(organizations: [addrequestModel.Organization], view: UIViewController)
   {
    organizationName.removeAll()
    
        
        for item in organizations{
            organizationName.append(item.name!)
        }
        
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: organizationName) { (cell, name, indexpath) in
            cell.textLabel?.text = name
        }
        menu.setSelectedItems(items: selectedOrgName) {[weak self] (item, index, isselected, selectedItem) in
            self?.selectedOrgName = selectedItem
            
        }
        menu.cellSelectionStyle = .checkbox
    
            menu.show(style: .alert(title: "ddddd", action: "ok", height: 300.0), from: view)
           print("hamada")
    
           // on dismiss handler
        menu.onDismiss = { [weak self] items in
            self?.selectedOrgName = items
            var indexes: [Int] = [Int]()
            for item in 0..<self!.selectedOrgName.count{
                let insed = organizations.index(where: {$0.name == self?.selectedOrgName[item]})
                indexes.append(insed!)

            }


            switch self?.type {
            case "organization":
                self?.seleted_organization_ID = organizations[indexes[0]].id!
                self?.selected_organization_Name = organizations[indexes[0]].name!
                

            case "countries":
                self?.selected_Country_ID = organizations[indexes[0]].id!
                self?.selected_Conutry_Name = organizations[indexes[0]].name!
                    self?.interactor.getCities(Countries_IDs: [(organizations[indexes[0]].id)!], complition: { (success, error, response) in
                        if success{
                            print("Getting succeedd")
                            self?.cities = response!
                        }

                        else{
                        }
                    })
            case "cities":
                self?.seleted_City_ID = organizations[indexes[0]].id!
                self?.selected_City_Name = organizations[indexes[0]].name!
            default:
                print("no case seleted")


        }

    }

    
    
}
    
    
    func getProveEmails(view: UIViewController)
    {
//        provementsEmails.removeAll()
        
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: provementsEmails) { (cell, name, indexpath) in
            cell.textLabel?.text = name
        }
        print("selected1)")
        menu.setSelectedItems(items: selectedEmails) {[weak self] (item, index, isselected, selectedItem) in
            self?.selectedEmails = selectedItem
        }
        menu.cellSelectionStyle = .checkbox
        
        menu.show(style: .alert(title: "ddddd", action: "ok", height: 300.0), from: view)
        menu.onDismiss = { [weak self] items in
            self?.selectedEmail = (self?.selectedEmails[0])!
            
            
        }
    }
}

