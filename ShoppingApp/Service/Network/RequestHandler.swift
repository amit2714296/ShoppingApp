

import Foundation

class RequestHandler {
    
    let reachability = Reachability()!
    
    func networkResult<T: Codable>(completion: @escaping ((Result<T, ErrorResult>) -> Void)) ->
    ((Result<Data, ErrorResult>) -> Void) {
        
        return { dataResult in
            
            DispatchQueue.global(qos: .background).async(execute: {
                switch dataResult {
                case .success(let data) :
                    let decoder = JSONDecoder()
                    guard let model = try? decoder.decode(T.self, from: data) else {
                        return completion(.failure(.parser(string: "Parsing error"))) }
                    completion(.success(model))
                    break
                case .failure(let error) :
                    print("Network error \(error)")
                    completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                    break
                }
            })
        }
    }
}
