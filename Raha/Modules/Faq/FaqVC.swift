//
//  FaqVC.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class FaqVC: BaseController {
    @IBOutlet weak var faqTbl: UITableView!
    var viewModel: FaqViewModel?
    var coordinator: FaqCoordinator?
}

// MARK: - ...  LifeCycle
extension FaqVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
        setup()
        bind()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.didError(error: error?.localizedDescription)
        })
        viewModel?.requestFinished.listen(on: { [weak self] value in
            self?.reload()
        })
    }
}
// MARK: - ...  Functions
extension FaqVC {
    func setup() {
        faqTbl.skeleton()
        faqTbl.delegate = self
        faqTbl.dataSource = self
        faqTbl.observe()
        viewModel?.fetchfaq()
    }
    func reload() {
        if viewModel?.dataSource()?.count ?? 0 == 0 {
            faqTbl.isHidden = true
            showEmptyScreen(for: 300, title: "Faqs list is empty".localized)
            
        } else {
            hideEmptyScreen()
            faqTbl.isHidden = false
        }
        faqTbl.skeleton()
        faqTbl.stopSwipeButtom()
        
    }
}
// MARK: - ...  View Contract
extension FaqVC {
}
extension FaqVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource()?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: FaqTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
