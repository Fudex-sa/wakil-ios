//
//
//

import CoreData

// MARK: - ...  Base Model for all models
class BaseModel<T: Codable>: Codable {
    var success: Bool?
    var message: String?
    var errorMessage: String?
    var errors: [String: [String]]?
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
        var errorMessage = ""
        for (field, error) in errors! {
        for error in error {
            errorMessage += "- \(error)\n"
        }
        }
//        for error in errors {
//            str.append("\(error.key[0] ?? "") : \(error.value ?? error.message ?? "") ")
//            break
//        }
        return errorMessage
        //return ""
    }
}


