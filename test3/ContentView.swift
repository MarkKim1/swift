    //
    //  ContentView.swift
    //  test3
    //
    //  Created by 김민석 on 2022/10/18.
    //

    import SwiftUI
    import Foundation

struct URLimage: View {
    let urlString: String
    
    @State var data:Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data:data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
        }else{
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
        
    }
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}
    struct ContentView: View {
        @StateObject var viewmodel = callAPI()
        var body: some View {
            NavigationView {
                List{
                    ForEach(viewmodel.newsfeed, id: \.self) { new in
                        HStack{
                            URLimage(urlString: new.url)
                        }
                    }
                }
                .navigationTitle("DOGS")
                .onAppear{
                    viewmodel.fetch()
                }
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
