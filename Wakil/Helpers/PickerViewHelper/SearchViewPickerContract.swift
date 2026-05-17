//
//  PickerSearchViewContract.swift
//  BaseIOS
//
//  Created by Mabdu on 08/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation


// MARK: - ...  Keyword protocol must every source implement this keyword
protocol Keyword {
    var name: String? { get set }
}
extension String: Keyword {
    var name: String? {
        get {
            return self
        }
        set {
            
        }
    }
}
// MARK: - ...  SearchViewPicker delegate
protocol SearchViewPickerDelegate: AnyObject {
    func searchViewPicker(_ searchViewPicker: SearchViewPicker?, didSelect item: Int)
    func searchViewPicker(_ searchViewPicker: SearchViewPicker?, didSelect item: RegisterModel)
}
extension SearchViewPickerDelegate {
    func searchViewPicker(_ searchViewPicker: SearchViewPicker?, didSelect item: Int) { }
    func searchViewPicker(_ searchViewPicker: SearchViewPicker?, didSelect item: RegisterModel) { }
}

typealias PickerDidSelectPath = (Int) -> Void
typealias PickerDidSelectItem = (RegisterModel) -> Void
