import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = UnSplashViewModel()
    @State private var openBottomSheet: Bool = false
    @State var selectedPic: Pic? = nil
    
    init() {
        viewModel.fetchPics()
        print("helloooo")
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    let picsWithIndices = Array(viewModel.pics.enumerated()) 

                    ForEach(picsWithIndices, id: \.0) { index, image in
                        AsyncImage(url: URL(string: image.urls.raw)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(10)
                                    .padding()
                            } else if phase.error != nil {
                                EmptyView()
                            } else {
                                ProgressView()
                            }
                        }
                        .onAppear {
                            if index == picsWithIndices.count - 1 {
                                viewModel.page += 1
                                viewModel.fetchPics()
                            }
                        }
                        .onTapGesture {
                            
                            print("\(image)")
                            
                            openBottomSheet.toggle()
                            selectedPic = image
                        }
                        .sheet(isPresented: $openBottomSheet){
                            
                            BottomSheetComp(image: $selectedPic, openBottomSheet:$openBottomSheet  )
                      
                        }
                    }
                }
            }
            .navigationTitle("Unsplash Images")
            .onAppear {
                viewModel.fetchPics()
            }
        }
    }
}

#Preview {
    ContentView()
}

