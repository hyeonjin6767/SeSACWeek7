//
//  ObservableExercise.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/11/25.
//

import Foundation

class ObservableExercise<T> {
    
//    var action: ((String) -> Void)? //함수를 갖고있는 프로퍼티
    private var action: ((T) -> Void)? //외부 호출없어서 private으로 해도 괜춘
    
//    var text: String {
    var text: T { //이름을 헷갈리지 않게 text보단 value를 많이 사용함!
        didSet {
            print("text didSet", oldValue, text)
            action?(text) //텍스트값이 변경됐을 때도 실행시켜주고 :세트!
        }
    }
    
//    init(_ text: String) {
    init(_ text: T) { //언더바로 매개변수 생략
        self.text = text
        print("ObservableExercise Init")
    }
    
    //매개변수로 받아온 함수를 실행을 해주는 함수
//    func playAction(play: @escaping (String) -> Void) {
    func playAction(play: @escaping (T) -> Void) {
        print(#function, "START")
        play(text) //넣자마자도 실행시켜주고 :세트!
        action = play //매개변수로 받아오면서 실행과 동시에 프로퍼티에 넣어줘서 nil이 아니게 만들어줘
        print(#function, "END")
    }
}
