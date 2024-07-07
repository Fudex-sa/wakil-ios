//
//  SearchViewPicker.swift
//  BaseIOS
//
//  Created by Mabdu on 08/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import UIKit

class SearchViewPicker: BaseController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var sourceTbl: UITableView! {
        didSet {
            sourceTbl.delegate = self
            sourceTbl.dataSource = self
        }
    }
    private (set) var searchSource: [Keyword] = []
    public weak var delegate: SearchViewPickerDelegate?
    public var source: [Keyword] = []
    public var pickTitle: Publisher<String> = .init()
    public var didSelectItem: Publisher<(Int, Keyword)> = .init()
    public var selectedRow: Publisher<IndexPath> = .init()
    public var showSearchBar: Publisher<Bool> = .init()
    
}


// MARK: - ...  Lifeycle
extension SearchViewPicker {
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBtn.isHidden = false
        doneBtn.isHidden = true
        searchBar.placeholder = "Search".localized
        searchSource.append(contentsOf: source)
        sourceTbl.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            if let constraint = self.sourceTbl.constraints.first(where: { $0.firstAttribute == .height }) {
                constraint.constant = self.sourceTbl.contentSize.height
                if constraint.constant > (self.view.height) - 400 {
                    constraint.constant = (self.view.height) - 400
                }
            }
        }
        
//        if showSearchBar {
//
//        } else {
//
//        }
        actions()
    }
    func actions() {
        pickTitle.listen(on: { [weak self] value in
            self?.titleLbl.text = value
        })
        showSearchBar.listen(on: { [weak self] value in
            if value ?? true {
                self?.searchBar.isHidden = false
                self?.searchBar.placeholder = "Search".localized
            } else {
                self?.searchBar.isHidden = true
                if let constraint = self?.searchBar.constraints.first(where: { $0.firstAttribute == .height }) {
                    constraint.constant = 0
                }
            }
        })
        
        selectedRow.listen(on: { [weak self] path in
            self?.done(id: path?.row)
        })
        doneBtn.publisher.listen { output in
            self.done(id: self.selectedRow.publisher?.value?.row)
        }.store(self)
        
        
    }
    
    func done(id: Int?) {
        guard let id = id else { return }
        self.dismiss(animated: true) { [weak self] in
            if (self?.searchSource.count ?? 0) > 0 {
                guard let item = self?.searchSource[id] else { return }
                self?.delegate?.searchViewPicker(self, didSelect: id)
                self?.delegate?.searchViewPicker(self, didSelect: item)
                self?.didSelectItem.send((id, item))
            }
        }
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ...  search Technic
extension SearchViewPicker {
    func reset() {
        searchSource.removeAll()
        searchSource.append(contentsOf: source)
        sourceTbl.reloadData()
    }
    func search(_ text: String?) {
        guard let text = text else { return }
        searchSource.removeAll()
        source.forEach { [weak self] (keyword) in
            if keyword.title?.lowercased().contains(text.lowercased()) ?? false {
                self?.searchSource.append(keyword)
            }
        }
        sourceTbl.reloadData()
    }
}


// MARK: - ...  table view delegation & data source
extension SearchViewPicker: UITableViewDelegate, UITableViewDataSource {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = searchSource[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow.send(indexPath)
    }
}


// MARK: - ...  search bar delegation
extension SearchViewPicker: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print("Search")
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("did end search")
        makeSearch()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("begin search")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("did cancel")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("did change")
        makeSearch()
    }
    func makeSearch() {
        guard let text = searchBar.text else { return reset() }
        if text.isEmpty {
            reset()
        } else {
            search(text)
        }
    }
}

