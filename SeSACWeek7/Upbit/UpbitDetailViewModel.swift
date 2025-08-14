//
//  UpbitDetailViewModel.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/12/25.
//

import Foundation


final class UpbitDetailViewModel {
    
    
    var outputTitle: ReviewObservable<String?> = ReviewObservable("")
    
    init() {
        print("UpbitDetailViewModel Init")
        
        print(outputTitle.value)
        
        outputTitle.bind { [weak self] in
            guard let self = self else { return }
            
            print("outputTitle의 bind", self.outputTitle.value)
        }
        
    }
    
    //디인잇이 안되고 있진 않은지 체크하려면 찍어서 확인해보는게 방법 : 내가 메모리 누수를 발생시키고 있진 않은지 체크
    deinit {
        
        print("UpbitDetailViewModel deinit") //화면전환시 디인잇이 프린트되고 있지 않았다면 메모리 누수가 발생하고 있었다는 것: 개선 필요.
    }
    
}
