//
//  ReviewNumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation




final class ReviewNumberViewModel {
    /*
     
     "인풋 아웃풋 합치기?"
     인풋 아웃풋이 너무 많을때 그룹을 만들자
     */

    
    //구조체라 사실 다른 파일에 만들어도 되.: 어차피 여기 클래스에서만 사용될 꺼라 여기 뷰모델안에 두는 것
    //뷰컨에서 뷰모델로 들어온 값
    struct Input { //인풋 스트럭트에 대한 인스턴스를 만들어 사용: 아래에
        var amount: ReviewObservable<String?> = ReviewObservable(nil)
    }
    //뷰모델에서 뷰컨으로 보여질 값
    struct Output {
        var amount: ReviewObservable<String> = ReviewObservable("")
    }
    //구조체의 인스턴스 생성 + 초기화도 아래 인잇에 해줘야 함
    var input: Input      // var input = Input : 선언과 초기화 동시에도 가능
    var output: Output
    
    
    
//    var hello: [String] = []
//    var sesac: Array<String> = [] //배열의 축약형
    
//    var inputAmount: ReviewObservable<String?> = ReviewObservable(nil)
    
//    var outputAmount: ReviewObservable<String> = ReviewObservable("")
    
    init() {
        
        //인스턴스에 대한 "초기화"도 진행되어야 함
        input = Input() //"커스텀뷰" 만들어서 사용할 때와 비슷한 형태
        output = Output()
        
        
        
        //inputAmount가 달라질때 마다 실행시키고 싶은 것
//        inputAmount.bind {
        input.amount.bind {
            print("inputAmount 달라짐")
            
            //1.
            guard let text = self.input.amount.value else {
                print("nil인 상태")
                self.output.amount.value = "값을 입력해주세요" //빌드 직후 보이는 레이블 값
                return
            }
            
            //2.
            if text.isEmpty {
                print("값을 입력해주세요")
                self.output.amount.value = "값을 입력해주세요"
                return
            }
            
            //3.
            guard let num = Int(text) else {
                print("숫자만 입력해주세요")
                self.output.amount.value = "숫자만 입력해주세요"
                return
            }
            
            //4.
            if num > 0, num <= 10000000 {
                
                let format = NumberFormatter()
                format.numberStyle = .decimal
                let wonResult = format.string(from: num as NSNumber)!
                print("₩" + wonResult)
                self.output.amount.value = "₩" + wonResult
                
            } else {
                print("1,000만원 이하를 입력해주세요")
                self.output.amount.value = "1,000만원 이하를 입력해주세요"
            }
        }
        
       
        
    }
    
}
