//
//  APISniper.swift
//  TechieButler
//
//  Created by Ravindra Arya on 03/05/24.
//

import Foundation

protocol Managable
{
    func fetchData<T : Codable>(request : URLRequest, returnType : T.Type) async throws -> T
}

let baseUrl = "https://jsonplaceholder.typicode.com/posts"

class APISniper : Managable
{
    static let shared = APISniper()
    private init() {}
    func fetchData<T>(request: URLRequest, returnType: T.Type) async throws -> T where T : Decodable, T : Encodable {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

enum DataRequest
{
    case baseUrl(String,Int,Int)
}


struct DataRequestModel
{
    var page : Int?
    var limit : Int?
    func getUrlRequest() -> URLRequest
    {
       return URLRequest(url: URL(string : baseUrl + "?_page=\(page ?? 1)&_limit=\(limit ?? 1)")!)
    }
}
