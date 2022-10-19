//
//  parseAPI.swift
//  test3
//
//  Created by 김민석 on 2022/10/18.
//

import Foundation
struct Article: Hashable, Codable{
    var id: String
    var url: String
    var width: Int
    var height: Int
}

class callAPI: ObservableObject {
    @Published var newsfeed:[Article] = []
    
    func fetch() {
        guard let url = URL(string: "https://api.thedogapi.com/v1/images/search?limit=5&page=10&order=Desc") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }
            let decoder = JSONDecoder()
            if let data = data {
                do{
                    let decode = try decoder.decode([Article].self, from: data)
                    DispatchQueue.main.async {
                        self.newsfeed = decode
                    }
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
}


