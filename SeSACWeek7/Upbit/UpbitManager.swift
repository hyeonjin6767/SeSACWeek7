//
//  UpbitManager.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/12/25.
//

import Foundation
import Alamofire

final class UpbitManager {
    
    //싱글턴 구성
    static let shared = UpbitManager()
    
    private init() { }
    
    func callRequest(completionHandler: @escaping ([Upbit], String) -> Void) {
        print(#function)
        
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url)
//            .responseString { data in
//            print(data)
//        }
            .responseDecodable(of: [Upbit].self) { response in
            switch response.result {
            case .success(let value):
                //print(value)
                
                let random = value.randomElement()?.korean_name
                completionHandler(value, random!)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
