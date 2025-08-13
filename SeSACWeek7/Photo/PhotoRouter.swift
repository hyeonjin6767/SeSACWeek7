//
//  PhotoRouter.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/13/25.
//

import Foundation
import Alamofire
//AF.request를 하기 전에 필요한 것들을 한 곳에서 관리하는 역할 :url, 파라미터, 헤더 등등 관리

enum PhotoRouter { //이넘의 "연산 프로퍼티"들 활용
    
    //열거형에도 사용할 수 있는 매개변수가 있다. : 이미 서버요청에서 sucess랑 fail 스위치문에서 매개변수를 value로 사용중이었음..
    case one(id: Int) //케이스를 함수처럼 본다면 매개변수를 넣을 수 있는 자리를 만들어두면 됨 : 써도 되고 안써도 되고 상관 없음(메서드의 모든 케이스가 get처럼 다짜고짜 return인 경우 switch self 구문이 자동완성 되어서 자동으로 써져도 지우고 사용안해도 괜춘): 매개변수 "갯수"만 맞으면 되서 jack같은 어떤 이름이 들어가도 상관 없음:보통은 일치시킴
    case list
    
    var baseURL: String {
        
        return "https://picsum.photos/" // 휴먼 에러 슬러시(/) 주의!
    }
    
    //최종적으로 요청하는 url을 보통 endpoint : 케이스별로 다른 url
    //let url = "https://picsum.photos/id/\(id)/info"
    //let url = "https://picsum.photos/v2/list?page=1&limit=20"
    var endpoint: URL {
        switch self {
        case .one(let jack): //프로퍼티는 매개변수를 가질수가 없으니 열거형에도 매개변수처럼 쓸 수 있는 기능이 존재함
            URL(string: baseURL + "id/\(jack)/info")! //URL자체가 무조건 옵셔널
        case .list:
//            URL(string: baseURL + "v2/list?page=1&limit=20")!
            URL(string: baseURL + "v2/list")!

        }
    }
    //Alamofire는 보통 겟으로 생략되어져 있음
    var method: HTTPMethod {
        return .get //모든 케이스가 다 겟이야: 케이스마다 다르면
    }
    
    //url 뒤에 쿼리스트링 파라미터 만들어보자
    var parameter: Parameters { //Parameters를 애플에서 제공
        switch self {
        case .one(let id):
            return ["":""]
        case .list:
            return ["page": "1", "limit": "20"]
        }
    }

    //헤더가 필요한 경우 사용
//    var headers: HTTPHeaders {
//        return ["Authorization" : "dㅓㅏ핳오ㅓ라htdh"]
//    }
}
