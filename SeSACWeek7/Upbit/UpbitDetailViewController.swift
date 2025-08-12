//
//  UpbitDetailViewController.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/12/25.
//

import UIKit

class UpbitDetailViewController: UIViewController {

    let viewModel = UpbitDetailViewModel()
    
    //var koreanData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        //navigationItem.title = "상세 화면" //koreanData ?? ""
        
        viewModel.outputTitle.bind {
            let data = self.viewModel.outputTitle.value
            self.navigationItem.title = data
            print("outputTitle bind, \(data)") //프린트 자체가 안됨 :
            //뷰컨으로 로직을 옮기니 프린트가 되지 않음 : "bind" : Observable에서 bind에 들어간 action을 실행 시켜주지 않았음 : 게다가 첫번째로 들어간 값이라 매개변수로 받은 클로저 함수의 내용이 담겨져만 있지 실행되지 않음
            //bind로 전달한 함수를 - "바로 실행도 하고" didset action에 넣어둘지, - "실행하지 않고" didset action에 넣어둘지
            //해결 방법1. 여기서 직접 값 변경을 한번 시키기 방법2. bind에 함수 실행을 시켜주는 한 줄을 추가 할지
            //bind를 2개 만드는 방법도 있음!
        }
        
    }
    


}
