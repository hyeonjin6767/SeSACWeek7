//
//  PhotoManager.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import Foundation
import Alamofire

final class PhotoManager {
    
    static let shared = PhotoManager()
    
    private init() { }
    
    //아래 두 요청 메서드 하나로 합치기: 그릇만 빼고 다 똑같
    /*
     1. AF.request 메서드 자체를 하나로 만들어서 활용할 수 없나? - "meta type"
     router pattern 만들고 식판을 제네릭으로 만들고도 부족해서 meta type(T.type)까지 사용
     2. 요청 로직을 한곳에서 관리할 수 없을까?: 파라미터들이라던가 url주소들이 몇십개가 될 경우
     
     cf) parameters라는 매개변수는 쿼리스트링 자리가 될 수도 있고 post에 HTTP Body 영역이 될 수도 있어서: 자리를 지정해주는 애(encoding)가 따로 존재.
     
     */
    
    //그릇만 제네릭으로 하면 너무 뭐든 담을 수 있으니(테이블뷰같은것도 들어갈수 있어서) responseDecodable에서 에러남 : 외부데이터를 담을 수 있는 애(Decodable)로 한정지어줘야 해
    func callRequest<T: Decodable>(api: PhotoRouter, type: T.Type,
                                   success: @escaping (T) -> Void) { //T.Type라고 쓰는 이유는 이 자리에는 Photo.self, Photo.self같은 "타입"이 들어가야 하기 때문(그릇).
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString)).responseDecodable(of: T.self) { response in
            switch response.result { // T.self 라는 식판이 정해져야 아래 value가 정해지고 그다음 success: @escaping (T) -> Void의 T도 정해지는 순서
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //PhotoRouter라는 열거형을 매개변수로 받는 api라는 매개변수를 만들자,
    func getOnePhoto(api: PhotoRouter,
                     success: @escaping (Photo) -> Void) {
        AF.request(api.endpoint,
                   method: api.method) //Alamofire에 숨어있는 매개변수들을 활용해보자 : 열거형이 가지고 있는 연산프로퍼티들로 구성
            .responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    //위아래꺼가 거의 똑같(응답 데이터 담는 그릇만 달라) : 합칠수 없을까 : 맨위에 합친 것.
    func getPhotoList(api: PhotoRouter,
                      success: @escaping ([PhotoList]) -> Void) {
        AF.request(api.endpoint, method: api.method)
            .responseDecodable(of: [PhotoList].self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
//    func getOnePhoto(id: Int, success: @escaping (Photo) -> Void) {
//        let url = "https://picsum.photos/id/\(id)/info"
//        AF.request(url).responseDecodable(of: Photo.self) { response in
//            switch response.result {
//            case .success(let value):
//                success(value)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
   
}
