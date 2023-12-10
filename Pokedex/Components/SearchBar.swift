import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onSearchTextChange: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .foregroundColor(.primary)
                .overlay(
                    HStack {
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                                onSearchTextChange(searchText)
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.primary)
                                    .padding(.trailing, 16)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                )
        }
    }
}

//#Preview {
//    SearchBar()
//}
