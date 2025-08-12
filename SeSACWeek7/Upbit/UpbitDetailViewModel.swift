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
        
        outputTitle.bind {
            print("outputTitle의 bind", self.outputTitle.value)
        }
        
    }
    
}
