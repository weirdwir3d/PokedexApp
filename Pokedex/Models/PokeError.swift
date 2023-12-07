import Foundation

enum PokeError: LocalizedError {
    
    case general
    case noInternet
    
    var errorDescription: String? {
        switch self {
        case .general:
            return "something went wrong"
        case .noInternet:
            return "you appear to be offline"
        }
    }
}
