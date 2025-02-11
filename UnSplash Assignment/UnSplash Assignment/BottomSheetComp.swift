import SwiftUI

struct BottomSheetComp: View {
    @Binding var image: Pic?
    @Binding var openBottomSheet: Bool
    
    func callImage() {
        print("image url \(image?.urls.raw ?? "No URL" ) \(image)")
    }
    
    var body: some View {
        ScrollView(){
            LazyVStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Button(action: {
                        openBottomSheet = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                .padding(.leading) 
                
                if let url = URL(string: image?.urls.raw ?? "") {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let returnedImage):
                            returnedImage
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.7)
                                .clipped()
                                .onTapGesture {
                                    callImage()
                                }
                                .cornerRadius(20)

                        case .failure:
                            Text("Failed to load image")
                                .foregroundColor(.red)
                        }
                    }
                } else {
                    Text("Invalid image URL")
                }
                
                Text("\(image?.description ?? "A captivating blend of colors and composition, evoking a sense of wonder and curiosity.")")
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .bold()
                
                HStack(alignment: .firstTextBaseline, spacing: 10){
                    Image(systemName: "heart.fill")
                        .frame(width:20, height:20)
                        .foregroundColor(.red)
                    
                    Text("\(image?.likes ?? 0)")
                        .foregroundStyle(.black)
                        .font(.footnote)
                        
                }
                
            }
            .background(Color.white)
        }
        .padding()
        .edgesIgnoringSafeArea(.all) 
        
    }
}
