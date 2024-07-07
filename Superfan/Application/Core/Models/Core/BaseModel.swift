//
//
//

import CoreData

// MARK: - ...  Base Model for all models
class BaseModel<T: Codable>: Codable {
    var success: Bool?
    var message: String?
    var errorMessage: String?
    var errors: Errors?
    var error: Erro?
    var responseData: T?
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case errorMessage
        case errors
        case error
        case responseData
    }
    func description() -> String {
//        let str: NSMutableString = NSMutableString()
//        for error in errors {
//            str.append("\(error.key ?? "") : \(error.value ?? error.message ?? "") ")
//            break
//        }
//        return str as String
        return ""
    }
}

struct ForceUpdateModel: Codable {
    var signalRUrl: String?
    var version: String?
    var newVersion: String?
    var apiUrl: String?
    var guestToken: String?
}
