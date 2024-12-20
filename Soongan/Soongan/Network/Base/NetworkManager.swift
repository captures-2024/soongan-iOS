//
//  NetworkManager.swift
//  NanaLand
//
//  Created by 정현우 on 4/17/24.
//

import Foundation
import Alamofire
@MainActor
class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Decodable>(_ endPoint: EndPoint) async -> BaseResponse<T>? {
        let request = makeDataRequest(endPoint)
        let result = await request.serializingData().result
        var data = Foundation.Data()
        // 데이터 fetch 단계
        do {
            print("Request Headers: \(endPoint.headers)")
            print("EndPoint: \(endPoint)")
            data = try result.get()
        } catch {
            print("Data fetch error: \(error.localizedDescription)")
            print("Endpoint: \(endPoint)")
            return nil
        }
        
        // 데이터 decode 단계
        do {
            let decodedData = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
            return decodedData
        } catch {
            // 디코딩 오류 출력
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            } else {
                print("Response data is not valid UTF-8.")
            }
            print("Decoding error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func makeDataRequest(_ endPoint: EndPoint) -> DataRequest {
        switch endPoint.task {
        case .requestPlain:
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                headers: endPoint.headers,
                interceptor: Interceptor()
            )
        case let .requestParameters(parameters):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: endPoint.headers,
                interceptor: Interceptor()
            )
        case let .requestJSONEncodable(body):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: body,
                encoder: JSONParameterEncoder.default,
                headers: endPoint.headers,
                interceptor: Interceptor()
            )
        case let .requestWithoutInterceptor(body):
            if body == nil {
                return AF.request(
                    "\(endPoint.baseURL)\(endPoint.path)",
                    method: endPoint.method,
                    headers: endPoint.headers
                )
            } else {
                return AF.request(
                    "\(endPoint.baseURL)\(endPoint.path)",
                    method: endPoint.method,
                    parameters: body!,
                    encoder: JSONParameterEncoder.default,
                    headers: endPoint.headers
                )
            }
            
        case let .requestJSONWithImage(multipartFile, body, withInterceptor):
            guard let url = URL(string: "\(endPoint.baseURL)\(endPoint.path)") else {
                print("Invalid URL")
                return AF.upload(multipartFormData: { _ in }, to: "")
            }
            
            return AF.upload(multipartFormData: { multipartFormData in
                for (index, data) in multipartFile.enumerated() {
                    // 파일 데이터 추가
                    if let imageData = data {
                        let fileName = "\(index).jpeg"
                        multipartFormData.append(imageData, withName: "multipartFile", fileName: fileName, mimeType: "image/jpeg")
                        print("Appending image data with file name: \(fileName)")
                    }
                }
                //이름 데이터 추가
                if let nickname = AppState.shared.nickName.data(using: .utf8) {
                    multipartFormData.append(nickname, withName: "nickname")
                    print("Appending Nickname: \(AppState.shared.nickName)")
                } else {
                    print("Nickname is nil")
                }
            }, to: url, method: endPoint.method, headers: endPoint.headers, interceptor: withInterceptor ? Interceptor() : nil)
            .response { response in
                print("Response: \(response.debugDescription)")
            }
   

        }
    }
}
