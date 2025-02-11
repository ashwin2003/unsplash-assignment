import SwiftUI

class UnSplashViewModel: ObservableObject {
    @Published var pics: [Pic] = []
    @Published var page = 1
    private var isLoading = false // Prevent multiple API calls

    func fetchPics() {
        guard !isLoading else { return } // Prevent duplicate requests
        isLoading = true

        let urlString = "https://api.unsplash.com/photos/?page=\(page)&client_id=X0hRpgY1MEvNZxgxIpzxV_58KRLKXuyiEaytz-8bVMY"
        print("Fetching: \(urlString)")
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let data = data {
                do {
                    let decodedPosts = try JSONDecoder().decode([Pic].self, from: data)
                    
                    print("dededede \(decodedPosts)")
                    DispatchQueue.main.async {
                        self.pics.append(contentsOf: decodedPosts)
                        self.page += 1  
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
}
