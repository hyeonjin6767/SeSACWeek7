//
//  UpbitViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation
import Alamofire

final class UpbitViewModel {
    
    //셀 선택시 트리거와 함께 값전달도 동시에 받아보자
    var inputCellSelectedTrigger: ReviewObservable<Upbit?> = ReviewObservable(nil)
    //셀 클릭시 트리거 전달 받아보자
//    var inputCellSelectedTrigger: ReviewObservable<Void> = ReviewObservable(())
    
    
    //화면이 뜨기 직전이다라는 생명주기를 얻어 오고싶다.
    var inputViewDidLoadTrigger: ReviewObservable<Void> = ReviewObservable(()) //빈 튜플 넣어주기
    
    var outputMarketData: ReviewObservable<[Upbit]> = ReviewObservable([]) //스트링 배열 더미데이터로 테스트 해보자
    
    //네비게이션 타이틀에 보여주고 싶은 내용
    var outputNavigationTitleData = ReviewObservable("")
    
//    var outputCellSelected: ReviewObservable<Void> = ReviewObservable(())
    var outputCellSelected: ReviewObservable<String> = ReviewObservable("")

    
    init() {
        
        inputCellSelectedTrigger.bind {
            print("viewModel inputCellSelectedTrigger")
            print("셀이 선택되었습니다")
            print(self.inputCellSelectedTrigger.value)
            self.outputCellSelected.value = self.inputCellSelectedTrigger.value?.korean_name ?? ""
        }
        
        inputViewDidLoadTrigger.lazyBind {
            print("viewModel inputViewDidLoadTrigger")
            print("ViewDidLoad 시점")
            
            //self.outputMarketData.value = ["d","a","f","w","g"] //데이터가 달라지는 시점
            
            self.callRequest() //bind로 하면 서버 요청이 2번 일어남: lazybind로 변경하면 통신이 한번만 일어남
            //혹은, 중복 호출 방지를 위해서는 bind를 사용하되, 뷰컨 뷰디드로드에서 트리거를 주지 않으면 됨!
            
        }
        
       
    }
    
    //1. 통신이 잘되는지 먼저 체크 : 안되면 responseString로 프린트해서 확인 : 잘 불러온다면 식판에 담기는게 안되는 것
    
    func callRequest() {
        print(#function)
        
        UpbitManager.shared.callRequest { market, title in
            self.outputMarketData.value = market
            self.outputNavigationTitleData.value = title
        }
        
//        let url = "https://api.upbit.com/v1/market/all"
//        AF.request(url)
////            .responseString { data in
////            print(data)
////        }
//            .responseDecodable(of: [Upbit].self) { response in
//            switch response.result {
//            case .success(let value):
//                //print(value)
//                
//                //마켓데이터의 데이터가 수정이 되는지 체크
//                self.outputMarketData.value = value
//                let random = value.randomElement()?.korean_name
//                self.outputNavigationTitleData.value = random ?? ""
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
}
