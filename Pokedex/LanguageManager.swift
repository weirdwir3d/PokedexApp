import Foundation

class LanguageManager {
    static let shared = LanguageManager()

    private init() {}

    func setLanguage(_ languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }

    func currentLanguage() -> String {
        return UserDefaults.standard.string(forKey: "AppleLanguages") ?? "en"
    }
}
