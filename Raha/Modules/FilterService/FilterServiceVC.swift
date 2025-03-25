//
//  FilterServiceVC.swift
//  Raha
//
//  Created by ADAM on 02/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol FilterServiceVCDelegate: AnyObject {
    func done(model : FilterServiceModel)

}
// MARK: - ...  ViewController - Vars
class FilterServiceVC: BaseController {
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var star1Img: UIImageView!
    @IBOutlet weak var star2Img: UIImageView!
    @IBOutlet weak var star3Img: UIImageView!
    @IBOutlet weak var star4Img: UIImageView!
    @IBOutlet weak var star5Img: UIImageView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var femaleRadio: RadioButton!
    @IBOutlet weak var maleRadio: RadioButton!
    @IBOutlet weak var centerRadio: RadioButton!
    @IBOutlet weak var homeRadio: RadioButton!
    @IBOutlet weak var typesCollection: UICollectionView!
    var viewModel: FilterServiceViewModel?
    var coordinator: FilterServiceCoordinator?
    var filter : FilterServiceModel = FilterServiceModel.init()
    var distances: [RegisterModel] = []
    var ServiceType: [RegisterModel] = []
    var delegate: FilterServiceVCDelegate?

}

// MARK: - ...  LifeCycle
extension FilterServiceVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension FilterServiceVC {
    func setup() {
        typesCollection.skeleton()
        typesCollection.delegate = self
        typesCollection.dataSource = self
        typesCollection.observe()
        distances.removeAll()
        distances.append(RegisterModel.init(id: 0, name: "All".localized))
        distances.append(RegisterModel.init(id: 2, name: "2 \("kilometer".localized)"))
        distances.append(RegisterModel.init(id: 4, name: "4 \("kilometer".localized)"))
        distances.append(RegisterModel.init(id: 6, name: "6 \("kilometer".localized)"))
        distances.append(RegisterModel.init(id: 8, name: "8 \("kilometer".localized)"))
        distances.append(RegisterModel.init(id: 10, name: "10 \("kilometer".localized)"))
        distances.append(RegisterModel.init(id: 15, name: "15 \("kilometer".localized)"))
        distances.append(RegisterModel.init(id: 20, name: "20 \("kilometer".localized)"))
        distances.append(RegisterModel.init(id: 25, name: "25 \("kilometer".localized)"))
        ServiceType.removeAll()
        ServiceType.append(RegisterModel.init(id: 0, name: "All".localized))
        ServiceType.append(RegisterModel.init(id: 1, name: "Massage".localized))
        ServiceType.append(RegisterModel.init(id: 2, name: "Cupping".localized))
        typesCollection.reloadData()
        if filter.servicetype == "home" {
            homeRadio.select()
        }else  if filter.servicetype == "center" {
            centerRadio.select()
        }
        if filter.gender == "male" {
            maleRadio.select()
        }else  if filter.servicetype == "female" {
            femaleRadio.select()
        }
        if filter.distance ?? "" != "" && filter.distance ?? "" != "0" {
            distanceLbl.text = "\(filter.distance ?? "") \("kilometer".localized)"
        }else {
            distanceLbl.text = "All".localized
        }
        homeRadio.onSelect(execute: { [self] in
            centerRadio.deselect()
            filter.servicetype = "home"
        })
        centerRadio.onSelect(execute: { [self] in
            homeRadio.deselect()
            filter.servicetype = "center"
        })
        maleRadio.onSelect(execute: { [self] in
            femaleRadio.deselect()
            filter.gender = "male"
        })
        femaleRadio.onSelect(execute: { [self] in
            maleRadio.deselect()
            filter.gender = "female"
        })
        star5Img.UIViewAction {
            self.filter.rate = "5"
        }
        star4Img.UIViewAction {
            self.filter.rate = "4"
        }
        star3Img.UIViewAction {
            self.filter.rate = "3"
        }
        star2Img.UIViewAction {
            self.filter.rate = "2"
        }
        star1Img.UIViewAction {
            self.filter.rate = "1"
        }
        distanceView.publisherGesture.listen(on: {[weak self] _ in
            self?.pickdistance()
        }).store(self)
        searchBtn.publisher.listen(on: {[weak self] _ in
            self?.delegate?.done(model: (self?.filter)!)
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
        clearBtn.publisher.listen(on: {[weak self] _ in
            self?.filter = FilterServiceModel.init()
            self?.maleRadio.deselect()
            self?.femaleRadio.deselect()
            self?.homeRadio.deselect()
            self?.centerRadio.deselect()
            self?.distanceLbl.text = "All".localized
            self?.typesCollection.reloadData()
        }).store(self)
    }
    func pickdistance() {
        let scene = SearchViewPicker(nib: R.nib.searchViewPicker)
        scene.pickTitle.send("Distance".localized)
        scene.source = distances
        scene.didSelectItem.listen(on: { [weak self] didSelect in
            guard let item = didSelect?.1 as? RegisterModel else { return }
            self?.distanceLbl.text = item.name ?? ""
            self?.filter.distance = item.id?.string ?? "0"
            self?.distanceLbl.textColor = R.color.black()
        })
        self.pushPop(scene)
    }
}
// MARK: - ...  View Contract
extension FilterServiceVC {
}
extension FilterServiceVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 95, height: typesCollection.height)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return ServiceType.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: ServicetypeCollectionViewCell.self, indexPath)
            cell.model = ServiceType[safe: indexPath.row]
            cell.serviceId = filter.servicetype?.int ?? 0
            cell.setupselect()
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filter.servicetype = ServiceType[safe: indexPath.row]?.id?.string ?? "0"
        typesCollection.reloadData()
    }
   
  }
