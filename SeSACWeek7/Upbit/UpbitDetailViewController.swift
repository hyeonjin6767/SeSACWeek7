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

        print(self, "viewDidLoad")

        view.backgroundColor = .white
        //navigationItem.title = "상세 화면" //koreanData ?? ""
        
        
        
        
        // "deinit이 실행이 안되면 보통 아래같은 self나 클로저문(bind, lazybind 등등)을 찾아주면 범인 색출 가능함"
        // 그냥 습관적으로 이런 클로저문에는 weak self를 사용해라 : 단언컨대 self가 쓰이는 곳에선 거의 다 누수가 발생하고 있다고 보면 됨
        viewModel.outputTitle.bind { [weak self] in //여기 self때문에 deinit이 안되고 있을 수 있으니 여기도 weak self
            guard let self = self else { return }
            
            let data = self.viewModel.outputTitle.value
            self.navigationItem.title = data
            print("outputTitle bind, \(data)") //프린트 자체가 안됨 :
            //뷰컨으로 로직을 옮기니 프린트가 되지 않음 : "bind" : Observable에서 bind에 들어간 action을 실행 시켜주지 않았음 : 게다가 첫번째로 들어간 값이라 매개변수로 받은 클로저 함수의 내용이 담겨져만 있지 실행되지 않음
            //bind로 전달한 함수를 - "바로 실행도 하고" didset action에 넣어둘지, - "실행하지 않고" didset action에 넣어둘지
            //해결 방법1. 여기서 직접 값 변경을 한번 시키기 방법2. bind에 함수 실행을 시켜주는 한 줄을 추가 할지
            //bind를 2개 만드는 방법도 있음!
        }
        
    }
    
    //dismiss가 될때 viewDidDisappear가 실행됨
    override func viewDidDisappear(_ animated: Bool) { //viewDidDisappear가 된다고 deinit이 실행되진 않아: 화면이 사라지더라도 메모리엔 남아 있을 수 있다(둘이 별개)
        super.viewDidDisappear(animated)
        print(self, "disappear")
    }
    //화면 왔다갔다하면 계속 서로 다른 주소값을 지닌 init이 찍힘 : viewDidDisappear 다음에 deinit이 호출이 됨
    init() {
        super.init(nibName: nil, bundle: nil)
        print(" UpbitDetailViewController init") //인잇이 되고 완벽하게 사라지면 디인잇이 되고 다시 인잇이 되고 다시 디인잇이 되고
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //deinit이 안되고 있진 않은지 체크하려면 프린트로 확인해보는게 방법 : 내가 메모리 누수를 발생시키고 있진 않은지 체크 : 요즘에 메모리 누수가 발생해도 디바이스 자체가 너무 좋아서 큰 티가 안남 : 가끔 발열 이슈는 발생하므로 습관을 들여주는게 좋아
    deinit {
        
        print(" UpbitDetailViewController deinit") //안찍혀서 [weak self] in guard let self = self else { return }추가했더니 실행됨
    }
    

}
