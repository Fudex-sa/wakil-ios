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
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var centerLbl: UILabel!
    @IBOutlet weak var femaleLbl: UILabel!
    @IBOutlet weak var maleLbl: UILabel!
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
    var ServiceType: [ServicetypeDatum] = []
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
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.servicestypeFinished.listen(on: { [weak self] value in
            self?.servicetypereload()
        })
       
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
        viewModel?.fetchservicestype()
        if filter.servicetype == "home" {
            homeLbl.textColor = R.color.black1()
            centerLbl.textColor = R.color.darkgray2()
            homeRadio.select()
        }else  if filter.servicetype == "center" {
            centerLbl.textColor = R.color.black1()
            homeLbl.textColor = R.color.darkgray2()
            centerRadio.select()
        }
        if filter.gender == "male" {
            maleLbl.textColor = R.color.black1()
            femaleLbl.textColor = R.color.darkgray2()
            maleRadio.select()
        }else  if filter.servicetype == "female" {
            femaleRadio.select()
            femaleLbl.textColor = R.color.black1()
            maleLbl.textColor = R.color.darkgray2()
        }
        if filter.distance ?? "" != "" && filter.distance ?? "" != "0" {
            distanceLbl.text = "\(filter.distance ?? "") \("kilometer".localized)"
        }else {
            distanceLbl.text = "All".localized
        }
        homeRadio.onSelect(execute: { [self] in
            centerRadio.deselect()
            filter.loctype = "home"
            homeLbl.textColor = R.color.black1()
            centerLbl.textColor = R.color.darkgray2()
        })
        centerRadio.onSelect(execute: { [self] in
            homeRadio.deselect()
            filter.loctype = "center"
            centerLbl.textColor = R.color.black1()
            homeLbl.textColor = R.color.darkgray2()
        })
        maleRadio.onSelect(execute: { [self] in
            femaleRadio.deselect()
            filter.gender = "male"
            maleLbl.textColor = R.color.black1()
            femaleLbl.textColor = R.color.darkgray2()
        })
        femaleRadio.onSelect(execute: { [self] in
            maleRadio.deselect()
            filter.gender = "female"
            femaleLbl.textColor = R.color.black1()
            maleLbl.textColor = R.color.darkgray2()
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
        closeBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
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
    func servicetypereload() {
        ServiceType.removeAll()
        ServiceType.append(ServicetypeDatum(key: "", value: "All".localized))
        ServiceType.append(contentsOf: viewModel?.servicestype.value ?? [])
        typesCollection.reloadData()
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
            cell.serviceId = filter.servicetype ?? ""
            cell.setupselect()
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filter.servicetype = ServiceType[safe: indexPath.row]?.key ?? ""
        typesCollection.reloadData()
    }
   
  }
