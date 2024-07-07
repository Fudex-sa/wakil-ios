//___FILEHEADER___

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ___FILEBASENAME___: BaseController {
    var viewModel: ___VARIABLE_moduleName___ViewModel?
    var coordinator: ___VARIABLE_moduleName___Coordinator?
}

// MARK: - ...  LifeCycle
extension ___FILEBASENAME___ {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension ___FILEBASENAME___ {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ___FILEBASENAME___ {
}
