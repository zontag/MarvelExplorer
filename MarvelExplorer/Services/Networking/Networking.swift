import Foundation
import Combine

enum NetworkingMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Target {
    var baseURL: String { get }
    var path: String { get }
    var method: NetworkingMethod { get }
    var queryParams: [String: String?] { get }
}

protocol TargetRequestable {
    func request<ResultType>(_ target: Target) -> AnyPublisher<ResultType, Error> where ResultType: Decodable
}

extension URLSession: TargetRequestable {

    private func makeRequest(_ target: Target) -> Result<URLRequest, URLError>.Publisher {
        var components = URLComponents()
        components.scheme = "https"
        components.host = target.baseURL
        components.queryItems = target.queryParams.compactMap { (param) -> URLQueryItem? in
            guard let value = param.value, !value.isEmpty else { return nil }
            return URLQueryItem(name: param.key, value: value)
        }
        components.path = target.path
        guard let url = components.url
        else { return Result.Publisher(.failure(URLError(.badURL)))}
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        return Result.Publisher(.success(request))
    }

    private func mapOutputToData(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let httpResponse = output.response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode)
        else { throw URLError(.badServerResponse) }
        return output.data
    }

    func request<ResultType>(_ target: Target) -> AnyPublisher<ResultType, Error> where ResultType: Decodable {
        makeRequest(target)
            .flatMap(self.dataTaskPublisher)
            .tryMap(mapOutputToData)
            .decode(type: ResultType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
