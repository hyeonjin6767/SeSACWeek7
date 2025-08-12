//
//  ReviewViewController.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/12/25.
//

import UIKit

class ReviewViewModel {
    
    let text = ReviewObservable("안녕하세요")
    
    //뷰컨보다 뷰코델이 먼저 init이 될 수 밖에 없다.
    //즉, ReviewObservable의 didset action에 기능이 들어간 상태
    
    init() {
        
        print("ReviewViewModel init")
        
//        text.bind {
//            print("init속 text bind")
//        }
        text.lazyBind {
            print("init속 text lazybind")

        }
    }
}

class ReviewViewController: UIViewController {

    //let number = ReviewObservable(100)
    let viewModel = ReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        print(#function)
        
        viewModel.text.value = "slkdg" //임의로 값의 변화 주기
        
//        number.lazyBind {
//            print("number lazybind")
//            self.navigationItem.title = "\(self.number.value)"
//        }
        
        
//        number.bind {
//            print("number bind")
//            self.navigationItem.title = "\(self.number.value)"
//        }
//        number.value = 50 //데이터 변화 줘보기
    }
    
    
}
