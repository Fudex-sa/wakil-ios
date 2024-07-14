import Alamofire
import UIKit
// MARK: - ...  Base Network manager // downloader // paginator // alertable
class BaseNetworkManager: Downloader, Paginator, Alertable, Combining {
    private var url: String {
        get {
            NetworkConfigration.URL
        }
    }
    private var header: HTTPHeaders {
        get {
            return .init(headers)
        }
    }
    var paramaters: [String: Any] = [:]
    var headers: [HTTPHeader] = []
    var subscriptions: Set<Subscriptions> = []
    var HTTPRequestRunning: Publisher<Bool> = .init()
    var request: URLRequest?
    
    override init() {
        super.init()
        setupObject()
    }
    func run() {
        HTTPRequestRunning.send(true)
    }
    func stop() {
        HTTPRequestRunning.send(false)
    }
}
// MARK: - ...  Functions setup
extension BaseNetworkManager {
    // MARK: - ...  refresh for new request
    func refresh() {
        self.removeSubscription()
        setupObject()
        paginate()
    }
    // MARK: - ...  setup request object
    func setupObject() {
        headers.removeAll()
        //hide()
        setupAuth()
        headers.append(.init(name: "version", value: NetworkConfigration.VERSION))
        headers.append(.init(name: "Device", value: Constants.DEVICEID))
        headers.append(.init(name: "lang", value: Localizer.current.rawValue))
        headers.append(.init(name: "LOCALE-CODE", value: Localizer.current.rawValue))
        headers.append(.init(name: "Accept", value: "application/json"))
        headers.append(.init(name: "Accept-Language", value: Localizer.current.rawValue))
        //headers.append(.init(name: "Device", value: Constants.DEVICEID))
        headers.append(.init(name: "X-DEVICE-TYPE", value: "ios"))
        let info = Bundle.main.infoDictionary
        let currentVersion = info?["CFBundleShortVersionString"] as? String
        headers.append(.init(name: "X-APP-VERSION", value: currentVersion ?? ""))
        headers.append(.init(name: "Content-Type", value: "application/x-www-form-urlencoded"))

    }
    // MARK: - ...  setup auth header
    func setupAuth() {
        headers.append(.init(name: "Authorization", value: Authentication.shared.getAuth()))
    }
    // MARK: - ...  reset the object
    func resetObject() {
        self.paramaters = [:]
        setupObject()
    }
    // MARK: - ...  initailize the FULL URL
    func initURL(method: String, type: HTTPMethod) -> String {
        var url = ""
        if type == .get {
            let methodFull = queryString(method: method)
            url = self.url+methodFull
        } else {
            url = self.url+method
        }
        return url
    }
    func checkReachability() -> Bool {
        if !Reachability.isConnectedToNetwork() {
            //Coordinator.instance.networkFail()
            return false
        } else {
            return true
        }
    }
}
// MARK: - ...  Handle response for request
extension BaseNetworkManager {
    func response<M: Codable>(response: DataResponse<Any, AFError>, _ model: M.Type) -> NetworkResponse<M>? {
        print(response.value ?? "")
        self.stop()
        switch response.result {
        case .success(let result):
            var statusCode: Int?
            if let dic = result as? NSDictionary {
                statusCode = dic["statusCode"] as? Int
            }
            if statusCode == nil {
                statusCode = response.response?.statusCode
            }
            switch statusCode {
            case 200?:
                do {
                    guard let data = response.data else { return nil }
                    let model = try JSONDecoder().decode(M.self, from: data)
                    return (.success(model))
                } catch DecodingError.typeMismatch(let type , let context) {
                    let error = "Type \(type) mismatch: \(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                    print(error)
                    return (.failure(NetworkError.init(message: error)))
                } catch DecodingError.keyNotFound(let key, let context) {
                    let error = "Key \(key) mismatch: \(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                    print(error)
                    return (.failure(NetworkError.init(message: error)))
                } catch DecodingError.valueNotFound(let value, let context) {
                    let error = "Value \(value) mismatch: \(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                    print(error)
                    return (.failure(NetworkError.init(message: error)))
                } catch DecodingError.dataCorrupted(let context) {
                    let error = "\(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                    return (.failure(NetworkError.init(message: error)))
                } catch {
                    return (.failure(error))
                }
            case 201?:
                do {
                    let model = try JSONDecoder().decode(M.self, from: response.data ?? Data())
                    return (.success(model))
                } catch { return (.failure(error)) }
            case 400?:
                (UIApplication.topViewController() as? BaseController)?.stopLoading()
                let error: NetworkError = NetworkError.init(errors: getError(data: (response.data ?? Data()) ))
                return (.failure(error))
            case 429?:
                (UIApplication.topViewController() as? BaseController)?.stopLoading()
                let error: NetworkError = NetworkError.init(errors: getError(data: (response.data ?? Data()) ))
                return (.failure(error))
            case 403?:
                (UIApplication.topViewController() as? BaseController)?.stopLoading()
                let error: NetworkError = NetworkError.init(errors: getError(data: (response.data ?? Data()) ))
                return (.failure(error))
            case 401?:
                (UIApplication.topViewController() as? BaseController)?.stopLoading()
                Coordinator.instance.unAuthorized()
                UD.user = nil
            case 404?:
                (UIApplication.topViewController() as? BaseController)?.stopLoading()
                let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                return (.failure(error))
            case 422?:
                (UIApplication.topViewController() as? BaseController)?.stopLoading()
                let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                return (.failure(error))
            case 426?:
                (UIApplication.topViewController() as? BaseController)?.stopLoading()
                let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                return (.failure(error))
            case 500?:
                (UIApplication.topViewController() as? BaseController)?.stopLoading()
                let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                return (.failure(error))
            case 503?:
                Coordinator.instance.maintance()
            case .none:
                break
            case .some(let error):
                (UIApplication.topViewController() as? BaseController)?.stopLoading()
                let error: NetworkError = .init(message: error.string)
                return (.failure(error))
            }
        case .failure(let error):
            (UIApplication.topViewController() as? BaseController)?.stopLoading()
            if response.response?.statusCode == 401 {
                //self.handleReLogin(model: model, future: self.reLogin())
            } else {
                //self.makeAlert(error.localizedDescription, closure: {})
                NotificationBuilder().setTitle("Error".localized).setBody("Unexpected error from server".localized).setTheme(.warning).bulid()
                return .failure(NetworkError(error: nil))
            }
            //self.show()
        }
        return nil
    }
}
// MARK: - ...  Begin requets
extension BaseNetworkManager {
    @discardableResult
    func beginRequest<M: Codable>(for request: DataRequest?, model: M.Type, withSave save: Bool? = true) -> NetworkFuture<M?, NetworkError>? {
        guard let request = request else {
            return nil
        }

        self.run()
        if save == true {
            self.request = request.convertible.urlRequest
        }
        return NetworkFuture { promise in
            request.responseJSON { response in
                let parsing = self.response(response: response, model)
                switch parsing {
                case .success(let model):
                    promise(.success(model))
                case .failure(let error):
                    guard let error = error as? NetworkError else { return }
                    promise(.failure(error))
                case .none:
                    self.handleReLogin(model: model) { future in
                        future?.response(error: { _ in }, receiveValue: { model in
                            promise(.success(model))
                        }).store(self)
                    }
                }
            }
        }
    }
    func presentUploadProgress<M: Codable>(upload: UploadRequest, _ model: M.Type) -> NetworkFuture<M?, NetworkError>? {
        self.presenting()
        upload.uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
            self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            var progress = self.progressView.progress
            progress *= 100
            self.label.text = "\(Int(progress))"+"%"
        })
        return self.beginRequest(for: upload, model: model)
    }
}

// MARK: - ...  Re login
extension BaseNetworkManager {
    @discardableResult
    func forceUpdate() -> NetworkFuture<BaseModel<ForceUpdateModel>?, NetworkError>? {
        NetworkManager.instance.paramaters["device"] = "ios"
        return NetworkManager.instance.request(.forceUpdate, type: .get, BaseModel<ForceUpdateModel>.self)
    }
   
    private func reLogin() -> NetworkFuture<UserRoot?, NetworkError>? {
        if UD.userRemember == true && UserRoot.token() != nil {
            NetworkManager.instance.paramaters["phoneCode"] = UD.userPhoneCode ?? ""
            NetworkManager.instance.paramaters["phone"] = UD.userPhone ?? ""
            NetworkManager.instance.paramaters["email"] = UD.userEmail ?? ""
            NetworkManager.instance.paramaters["password"] = UD.userPassword ?? ""
            //NetworkManager.instance.paramaters["refreshKey"] = UserRoot.fetch()?.responseData?.refresh_Token
            let future = self.connectionRaw(NetworkConfigration.EndPoint.login.rawValue, type: .post, UserRoot.self, withSave: false)
            return future
        } else {
            Coordinator.instance.unAuthorized()
            return nil
        }
    }
    private func handleReLogin<M:Codable>(model: M.Type, closure: ((NetworkFuture<M?, NetworkError>?) -> Void)? = nil) {
        reLogin()?.response(error: { _ in
            Coordinator.instance.unAuthorized()
        }, receiveValue: { [weak self] user in
            let oldUser = UD.user
            oldUser?.responseData?.access_Token = user?.responseData?.access_Token ?? ""
            oldUser?.save()
            self?.setupObject()
            let future = self?.reCallRequest(model: model)
            closure?(future)
        }).store(self)
    }
    @discardableResult
    private func reCallRequest<M:Codable>(model: M.Type) -> NetworkFuture<M?, NetworkError>? {
        guard var lastRequest = self.request else { return nil }
        lastRequest.allHTTPHeaderFields = self.header.dictionary
        let request = AF.request(lastRequest)
        return self.beginRequest(for: request, model: model)
    }
}

// MARK: - ...  Make Requets
extension BaseNetworkManager {
    // MARK: - ...  Basic request with type
    @discardableResult
    func connection<M: Codable>(_ method: String, type: HTTPMethod, _ model: M.Type) -> NetworkFuture<M?, NetworkError>? {
        if !checkReachability() {
            return nil
        }
        var url = initURL(method: method, type: type)
        let paramters = self.paramaters
        self.resetObject()
        url = safeUrl(url: url)
        
        let request = AF.request(url, method: type, parameters: paramters, headers: self.header)
        print(url)
        print(paramters)
        
        return self.beginRequest(for: request, model: model)
    }
    
    // MARK: - ...  Advanced request for raw with json object
    @discardableResult
    func connectionRaw<M: Codable>(_ method: String, type: HTTPMethod, json: Data? = nil, _ model: M.Type, withSave save: Bool? = false) -> NetworkFuture<M?, NetworkError>? {
        if !checkReachability() {
            return nil
        }
        let url = initURL(method: method, type: type)
        print(url)
        let paramters = self.paramaters
        self.resetObject()
        let manager = AF
        manager.session.configuration.timeoutIntervalForRequest = 30
        manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        var session = URLRequest(url: URL(string: safeUrl(url: url))!)
        if json != nil {
            let paramString = String(data: json ?? Data(), encoding: String.Encoding.utf8)
            session.httpBody = paramString?.data(using: .utf8)
        } else {
            do {
                let data = try JSONSerialization.data(withJSONObject: paramters, options: [])
                let paramString = String(data: data, encoding: String.Encoding.utf8)
                session.httpBody = paramString?.data(using: .utf8)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
        headers.append(.init(name: "Content-Type", value: "application/json"))
        session.httpMethod = type.rawValue
        session.allHTTPHeaderFields = header.dictionary
        session.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
        let request = AF.request(session)
        return self.beginRequest(for: request, model: model, withSave: save)
    }
    // MARK: - ...  Advanced request for upload files & only file // type URL
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [URL], key: String,
                                      file: [String: URL?]? = nil, _ model: M.Type) -> NetworkFuture<M?, NetworkError>? {
        if !checkReachability() {
            return nil
        }
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()
        self.run()
        let upload = AF.upload(multipartFormData: { multipartFormData in
            var counter = 0
            files.forEach({ (item) in
                multipartFormData.append(item, withName: "\(key)[\(counter)]")
                counter += 1
            })
            if file != nil {
                file?.forEach({ (fileData) in
                    if let url = fileData.value {
                        multipartFormData.append(url, withName: "\(fileData.key)")
                    }
                })
            }
            for (key, value) in paramters {
                multipartFormData.append("\(value)".data(using: .utf8) ?? Data(), withName: key)
            } //Optional for extra parameters
        },to: url, headers: header)
        
        return presentUploadProgress(upload: upload, model)
    }
    
    // MARK: - ...  Advanced request for upload files & only file // type UIImage
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [UIImage], key: String, file: [String: UIImage?]? = nil, _ model: M.Type) -> NetworkFuture<M?, NetworkError>? {
        if !checkReachability() {
            return nil
        }
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()
        self.run()
        let upload = AF.upload(multipartFormData: { multipartFormData in
            var counter = 0
            for item in files {
                //multipartFormData.append(item, withName: "\(key)[\(counter)]")
                multipartFormData.append(item.jpegData(compressionQuality: 0.5) ?? Data(),
                                         withName: "\(key)[\(counter)]", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                counter += 1
            }
            if file != nil {
                file?.forEach({ (fileData) in
                    if let image = fileData.value {
                        multipartFormData.append(image.jpegData(compressionQuality: 0.5) ?? Data(),
                                                 withName: "\(fileData.key)", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                        
                    }
                })
            }
            for (key, value) in paramters {
                multipartFormData.append("\(value)".data(using: .utf8) ?? Data(), withName: key)
            } //Optional for extra parameters
        },to: url, headers: header)
        
        return presentUploadProgress(upload: upload, model)
        
    }
    // MARK: - ...  Advanced request for upload files & only file // type UIImage
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [String: UIImage]? = nil, file: [String: UIImage?]? = nil, _ model: M.Type) -> NetworkFuture<M?, NetworkError>? {
        if !checkReachability() {
            return nil
        }
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()
        self.run()
        let upload = AF.upload(multipartFormData: { multipartFormData in
            var counter = 0
            for item in files ?? [:] {
                //multipartFormData.append(item, withName: "\(key)[\(counter)]")
                multipartFormData.append(item.value.jpegData(compressionQuality: 0.5) ?? Data(),
                                         withName: "\(item.key)", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                counter += 1
            }
            if file != nil {
                file?.forEach({ (fileData) in
                    if let image = fileData.value {
                        multipartFormData.append(image.jpegData(compressionQuality: 0.5) ?? Data(),
                                                 withName: "\(fileData.key)", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                        
                    }
                })
            }
            for (key, value) in paramters {
                multipartFormData.append("\(value)".data(using: .utf8) ?? Data(), withName: key)
            } //Optional for extra parameters
        },to: url, headers: header)
        
        return presentUploadProgress(upload: upload, model)
    }
}
