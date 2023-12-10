import SwiftUI

struct LanguageToggleButton: View {
    var body: some View {
        Button(action: {
            toggleLanguage()
        }) {
            Image(systemName: "globe")
        }
        .padding()
    }

    private func toggleLanguage() {
        let currentLanguage = LanguageManager.shared.currentLanguage()
        let newLanguage = (currentLanguage == "en") ? "it" : "en"
        LanguageManager.shared.setLanguage(newLanguage)
    }
}

