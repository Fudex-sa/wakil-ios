//
//  DetailscentersVC.swift
//  Raha
//
//  Created by ADAM on 27/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class DetailscentersVC: BaseController {
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var countWidth: NSLayoutConstraint!
    @IBOutlet weak var centerLbl: UILabel!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var visitView: UIView!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var imageHight: NSLayoutConstraint!
    @IBOutlet weak var servicesTbl: UITableView!
    @IBOutlet weak var catsCollection: UICollectionView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var centerImg: UIImageView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var imagesCollection: UICollectionView!
    @IBOutlet weak var centerRadio: RadioButton!
    @IBOutlet weak var homeRadio: RadioButton!
    var viewModel: DetailscentersViewModel?
    var coordinator: DetailscentersCoordinator?
    var lat = 0.0
    var lng = 0.0
    var centerId = 0
    var loctype = ""
    var ServiceType: [ServicetypeDatum] = []
    var selectservices : [Service] = []
    var services : [Service] = []

}

// MARK: - ...  LifeCycle
extension DetailscentersVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        if loctype != "" {
            visitView.isHidden = true
        }
        viewModel = .init()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator = .init()
        coordinator?.view = self
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
        setup()
        bind()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator = nil
        viewModel?.centerdetails = .init()
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.didError(error: error?.localizedDescription)
        })
        viewModel?.centerdetails.listen(on: { [weak self] value in
            self?.reload()
        })
       
       
    }
}
// MARK: - ...  Functions
extension DetailscentersVC {
    func setup() {
        viewModel?.lat.send(lat)
        viewModel?.lng.send(lng)
        viewModel?.loctype.send(loctype)
        viewModel?.centerId.send(centerId)
        viewModel?.fetchcentersdetails()
        servicesTbl.skeleton()
        servicesTbl.delegate = self
        servicesTbl.dataSource = self
        servicesTbl.observe()
        imagesCollection.skeleton()
        imagesCollection.delegate = self
        imagesCollection.dataSource = self
        imagesCollection.observe()
        catsCollection.skeleton()
        catsCollection.delegate = self
        catsCollection.dataSource = self
        catsCollection.observe()
        ServiceType.removeAll()
        homeRadio.onSelect(execute: { [self] in
            centerRadio.deselect()
            homeLbl.textColor = R.color.black1()
            centerLbl.textColor = R.color.darkgray2()
            viewModel?.loctype.send("home")
            viewModel?.fetchcentersdetails()
        })
        centerRadio.onSelect(execute: { [self] in
            centerLbl.textColor = R.color.black1()
            homeLbl.textColor = R.color.darkgray2()
            homeRadio.deselect()
            viewModel?.loctype.send("center")
            viewModel?.fetchcentersdetails()
        })
        bookBtn.publisher.listen(on: {[weak self] _ in
            var error = ""
            if self?.viewModel?.loctype.value ?? "" == "" {
                error = "\(error) \("select visit type".localized)\n"
            }
            if self?.selectservices.count == 0 {
                error = "\(error) \("Select Service".localized)"
            }
            if error != "" {
                self?.didError(error: error)
                return
            }
            self?.coordinator?.bookservices(id: self?.centerId ?? 0)

        }).store(self)
       
    }
    func reload() {
        distanceLbl.text = viewModel?.centerdetails.value?.data?.distance ?? ""
        rateLbl.text = viewModel?.centerdetails.value?.data?.rate?.string ?? ""
        addressLbl.text = viewModel?.centerdetails.value?.data?.address ?? ""
        titleLbl.text = viewModel?.centerdetails.value?.data?.name ?? ""
        desLbl.text = viewModel?.centerdetails.value?.data?.description ?? ""
        centerImg.setImage(url: viewModel?.centerdetails.value?.data?.image ?? "")
        if viewModel?.centerdetails.value?.data?.homeServicesAvailable ?? 0 == 1 {
            homeView.isHidden = false
        }else {
            homeView.isHidden = true
        }
        if viewModel?.centerdetails.value?.data?.images?.count ?? 0 == 0 {
            imageHight.constant = 60
        }
        imagesCollection.reloadData()
        if viewModel?.centerdetails.value?.data?.services?.count ?? 0 == 0 {
            servicesTbl.isHidden = true
            showEmptyScreen(for: 500, title: "Services list is empty".localized)
            
        } else {
            hideEmptyScreen()
            servicesTbl.isHidden = false
        }
        if viewModel?.centerdetails.value?.data?.serviceTypes?.count ?? 0 > 0 {
            ServiceType.removeAll()
            ServiceType.append(ServicetypeDatum(key: "", value: "All services".localized))
            ServiceType.append(contentsOf: viewModel?.centerdetails.value?.data?.serviceTypes ?? [])
        }
        services.removeAll()
        services.append(contentsOf: viewModel?.centerdetails.value?.data?.services ?? [])
        catsCollection.reloadData()
        servicesTbl.skeleton()
        servicesTbl.stopSwipeButtom()
        var index1 = 0
        for index in services {
            for item in selectservices {
                if index.id == item.id {
                    services[index1].isselect = true
                }
            }
            index1 = index1 + 1
        }
        servicesTbl.reloadData()
    }
}
// MARK: - ...  View Contract
extension DetailscentersVC {
}
extension DetailscentersVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == catsCollection {
            return .init(width: 75, height: catsCollection.height)
        }else {
            return .init(width: collectionView.frame.width, height: collectionView.frame.height)
        }
       }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == imagesCollection {
            pageControll.currentPage = indexPath.row
        }
        }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if collectionView == imagesCollection {
              pageControll.numberOfPages = viewModel?.centerdetails.value?.data?.images?.count ?? 0
              return viewModel?.centerdetails.value?.data?.images?.count ?? 2
          }else {
              return ServiceType.count
          }
          
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == imagesCollection {
                var cell = collectionView.cell(type: SlidersCollectionViewCell.self, indexPath)
                cell.model = viewModel?.centerdetails.value?.data?.images?[safe: indexPath.row]
                cell.setupcenters()
                return cell
            }else {
                var cell = collectionView.cell(type: ServicetypeCollectionViewCell.self, indexPath)
                cell.model = ServiceType[safe: indexPath.row]
                cell.serviceId = viewModel?.servicetype.value ?? ""
                cell.setupselectdetails()
                return cell
            }
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == catsCollection {
            viewModel?.servicetype.send(ServiceType[safe: indexPath.row]?.key ?? "")
            catsCollection.reloadData()
            viewModel?.fetchcentersdetails()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // No spacing between cells to ensure they are adjacent
            return 0
    }
  }
extension DetailscentersVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == servicesTbl {
            let tableViewVisibleHeight = servicesTbl.bounds.size.height
               let tableViewContentHeight = servicesTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && servicesTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchcentersdetails()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == servicesTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchcentersdetails()
                } else {
                    scrollView.stopSwipeButtom()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: ServicesTableViewCell.self, indexPath)
        cell.model = services[safe: indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
        }else {
            if viewModel?.loctype.value ?? "" == "" {
                didError(error: "select visit type".localized)
                return
            }
            for index in services {
                if index.id == services[safe: indexPath.row]?.id {
                    if services[safe: indexPath.row]?.isselect == true {
                        services[indexPath.row].isselect = false
                        var index1 = 0
                        for item in selectservices {
                            if index.id == item.id {
                                selectservices.remove(at: index1)
                            }
                            index1 = index1 + 1
                        }
                    }else {
                        services[indexPath.row].isselect = true
                        selectservices.append(index)
                    }
                    servicesTbl.reloadData()
                    countLbl.text = selectservices.count.string ?? "0"
                    if selectservices.count == 0 {
                        countLbl.isHidden = true
                        countWidth.constant = 0
                    }else {
                        countLbl.isHidden = false
                        countWidth.constant = 20
                    }
                    break
                }
            }
        }
    }
    
}
