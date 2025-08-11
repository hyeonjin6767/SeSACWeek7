//
//  Observable.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/11/25.
//

import Foundation

// 있어빌리티...

class Observable {
    
    
    
    // 1. String타입 뿐만 아니라 다른 타입들도 들어올수 있는 환경으로 만들수는 없을까
    // 2. 코드를 반복을 줄여보자
    // 다양한 타입의 값을 넣어주기 위해 제네릭도 활용
    
    
    
    //private var hello: (() -> Void)? //private을 쓸 수 있는 이유는 바인드로 저쪽에서 넣어도 주고 실행도 해주니까 헬로는 여기 안에서만 쓰이기 때문에.
    //private var hello: ((String) -> Void)?
    private var hello: ((String) -> Void)?
    
    
    
    
    //처음에 들어오는 jack값은 didSet이 실행X : 첫값이 들어온거지 값이 변경된건 아니어서
    //프로퍼티 선언
//    var text: String {
//        didSet {
//            print("text 값이 바뀌었어요", oldValue, text)
//            //hello?()
//            hello?(text)
//        }
//    }
    var value: String { //text라 쓰면 헷갈리니까 보통 value로 지음
        didSet {
            print("text 값이 바뀌었어요", oldValue, value)
            //hello?()
            hello?(value)
        }
    }
    
    
    //프로퍼티 초기화 : 클래스의 모든 프로퍼티는 초기화가 필요하니까
//    init(text: String) {
//        self.text = text
//        print("text값을 초기화해서 Observable 인스턴스를 만들었다")
//    }
    init(text: String) {
        self.value = text
        print("text값을 초기화해서 Observable 인스턴스를 만들었다")
    }
    
    
    func bind(closure: @escaping (String) -> Void) { //@escaping: closure라는 매개변수를 바깥에서도 사용하려면 붙여야. 기본적으로 non-escaping
        print(#function, "START")
        closure(value) //매개변수로 들어온 클로저 함수를 실행을 하면서
        self.hello = closure //헬로에 클로저를 전달까지 하는 형태
        print(#function, "END")
    }
    
    //매개변수 추가
//    func bind(closure: @escaping (String) -> Void) { //@escaping: closure라는 매개변수를 바깥에서도 사용하려면 붙여야. 기본적으로 non-escaping
//        print(#function, "START")
//        closure(text) //매개변수로 들어온 클로저 함수를 실행을 하면서
//        self.hello = closure //헬로에 클로저를 전달까지 하는 형태
//        print(#function, "END")
//    }
    
//    func bind(closure: @escaping () -> Void) { //@escaping: closure라는 매개변수를 바깥에서도 사용하려면 붙여야. 기본적으로 non-escaping
//        print(#function, "START")
//        closure() //매개변수로 들어온 클로저 함수를 실행을 하면서
//        self.hello = closure //헬로에 클로저를 전달까지 하는 형태
//        print(#function, "END")
//    }
    
}
