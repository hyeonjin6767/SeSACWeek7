//
//  ReviewNumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class ReviewNumberViewModel {
    
//    var hello: [String] = []
//    var sesac: Array<String> = [] //배열의 축약형
    
    var inputAmount: ReviewObservable<String?> = ReviewObservable(nil)
    var outputAmount: ReviewObservable<String> = ReviewObservable("")
    
    init() {
        //inputAmount가 달라질때 마다 실행시키고 싶은 것
        inputAmount.bind {
            print("inputAmount 달라짐")
            
            //1.
            guard let text = self.inputAmount.value else {
                print("nil인 상태")
                self.outputAmount.value = ""
                return
            }
            
            //2.
            if text.isEmpty {
                print("값을 입력해주세요")
                self.outputAmount.value = "값을 입력해주세요"
                return
            }
            
            //3.
            guard let num = Int(text) else {
                print("숫자만 입력해주세요")
                self.outputAmount.value = "숫자만 입력해주세요"
                return
            }
            
            //4.
            if num > 0, num <= 10000000 {
                
                let format = NumberFormatter()
                format.numberStyle = .decimal
                let wonResult = format.string(from: num as NSNumber)!
                print("₩" + wonResult)
                self.outputAmount.value = "₩" + wonResult
                
            } else {
                print("1,000만원 이하를 입력해주세요")
                self.outputAmount.value = "1,000만원 이하를 입력해주세요"
            }
        }
        
       
        
    }
    
}
