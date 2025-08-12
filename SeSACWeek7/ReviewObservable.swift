//
//  ReviewObservable.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/12/25.
//

import Foundation

class ReviewObservable<T> {
    
    private var action: (() -> Void)?
    
    var value: T {
        didSet {
            print("ReviewObservable didSet")
            action?()
        }
    }
    
    init(_ value: T) {
        print("ReviewObservable Init")
        self.value = value
        
    }

    func bind(action: @escaping () -> Void) {
        print("ReviewObservable")
        action() // 어떤 상황에 필요할지, 필요하지 않을 순간은 언제일지(시작하자마자 화면 전환될 수 있는 문제가 발생) : bind를 2개 만들기!
        self.action = action
    }
    
    func lazyBind(action: @escaping () -> Void) {
        
        self.action = action
    }
    
}
