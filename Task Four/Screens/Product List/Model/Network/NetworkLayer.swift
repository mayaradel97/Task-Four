//
//  NetworkLayer\.swift
//  Task Four
//
//  Created by Mayar Adel on 1/28/22.
//

import Foundation
class NetworkLayer
{
    func getResponse<T:Codable>(of type: T.Type, url: URL,completion: @escaping (T?)->())
    {
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url)
        { (data, response, error) in
            guard  error == nil
            else
            {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            let results = try! decoder.decode(T.self, from: data!)
            completion(results)
        }
        task.resume()
        
    }
}
