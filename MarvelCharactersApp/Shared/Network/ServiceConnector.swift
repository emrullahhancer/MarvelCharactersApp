//
//  ServiceConnector.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import Foundation
import Moya
import Alamofire

enum Services {
    case Home(Params: [String: Any])
    case Comics(Params: [String: Any], CharacterID: String)
}

class ServiceConnector: NSObject {
    
    static let shared = ServiceConnector()
    let connectivityGroup = DispatchGroup()
    let baseurl = "https://gateway.marvel.com:443/v1/public/"
    
    let endpointClosure = { (target: Services) -> Endpoint in
        var url = target.baseURL.absoluteString + target.path
        print("url:\(url)")
        
        let endpoint = Endpoint (
            url: url,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
        return endpoint.adding(newHTTPHeaderFields: [:])
    }
    
    func connect(_ target : Services) {
        self.connect(target, success: nil)
    }
    
    func connect(_ target : Services, success: ((_ target : Services, _ response : String) -> ())?) {
        self.connect(target, success: success, error: nil)
    }
    
    func connect(_ target : Services, success: ((_ target : Services, _ response : String) -> ())?, error: ((_ target: Services, _ error: MoyaError) -> ())?) {
        
        
        let manager = ServerTrustManager(allHostsMustBeEvaluated: false,
                                         evaluators: [baseurl: DisabledTrustEvaluator()])

        let configuration = URLSessionConfiguration.af.default

        let session = Session(configuration: configuration, serverTrustManager: manager)
        
        var providerPlugin: [PluginType] = []
        providerPlugin = [NetworkLoggerPlugin()]
        configuration.timeoutIntervalForRequest = 10

        let provider = MoyaProvider<Services>(endpointClosure: endpointClosure, session: session, plugins: providerPlugin)
         
        
        connectivityGroup.notify(queue: .main) {
            provider.request(target) { result in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch result {
                case let .success(moyaResponse):
                    
                    //let statusCode = moyaResponse.statusCode
                    let dataString = String(data: moyaResponse.data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                    
                    if let ds = dataString {
                        //print("Status Code : ", statusCode)
                        print("Response : ", ds)
                        
                        if let body = moyaResponse.request?.httpBody {
                            let bodyString = String(decoding: body, as: UTF8.self)
                            print("[Request Body]: \(bodyString)")
                        }
                        
                        let headers = moyaResponse.response!.allHeaderFields
                        
                        if let s = success {
                            s(target, ds)
                        }
                    }
                    
                    break
                case let .failure(err):
                    print("Error : ", err.errorDescription!)
                    if let e = error {
                        e(target, err)
                    }
                }
                 
            }
        }
    }
}

// MARK: - TargetType Protocol Implementation
extension Services: TargetType {
    
    var headers: [String : String]? {
        var headerParamsExtra = Dictionary<String,String>()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT:0)
        headerParamsExtra["Content-Type"] = "application/json"
        
        switch self {
        default:
            headerParamsExtra["Content-Type"] = "application/json"
        }
        return headerParamsExtra
    }
    
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443/v1/public/")!
    }
    
    var path: String {
        switch self {
        case .Home:
            return "characters"
        case let .Comics(_, CharacterID):
            return "characters/\(CharacterID)/comics"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    
    var task: Task {
        switch self {
        case let .Home(Params), let .Comics(Params, _):
            if Params.first?.key != "" {
                return .requestParameters(parameters: Params, encoding: URLEncoding.queryString)
            } else {
                return .requestPlain
            }
        default:
            return .requestPlain
        }
    }
}
