//
//  DetailViewController.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/14/25.
//

import UIKit


class Hello {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class DetailViewController: UIViewController {
    
    var nickname = "고래밥" // 공간 차지 //deinit때 사라짐
    
//    func introduce() = { //deinit때 사라짐
//        print("안녕하세요 저는 \(nickname)입니다")
//    }
//
    
    
    
    
    //"메모리에서 내려가지 않는 누수가 발생하고 있는 코드"를 만들어 버렸다 : 왜때문? : self.nickname : 레이지 때문이 아니라 "self"때문이었음 : 여태 우리의 코드들은 엄청난 메모리 누수가 발생되고 있었던 것
    //위에 nickname과 동시 생성되서 에러: 그래서 조금이라도 늦추기 위해 얘는 레이지 : 그랬더니 deinit이 호출되지 않는 메모리 누수 발생 : 레이지 때문이 아니라 self 때문.
    //deinit때 사라짐
    lazy var test = { [weak self] in
        guard let self = self else { return }
        print("안녕하세요 저는 \(self.nickname)입니다") //self를 사용하고 있는 곳이 대체적으로 메모리 누수가 발생하고 있는 곳으로 의심: 그래서 습관적으로 weak self를 같이 써줌
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("DetailViewController viewDidLoad")

        print(nickname) //deinit때 사라짐
//        introduce() //deinit때 사라짐
        test()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil) //부모클래스의 인잇을 호출해줘야함(상속받는애가 있어서)
        print("DetailViewController Init")
        
    }
    
    //deinit이 안되고 있진 않은지 체크하려면 프린트로 확인해보는게 방법 : 내가 메모리 누수를 발생시키고 있진 않은지 체크 : 요즘에 메모리 누수가 발생해도 디바이스 자체가 너무 좋아서 큰 티가 안남 : 가끔 발열 이슈는 발생하므로 습관을 들여주는게 좋아
    //인잇이 사라지는 시점을 알려주는 deinit
    deinit {
        print("DetailViewController deinit") //화면이 왔다갔다해도 프린트가 안되는 경우(레이지안에 셀프 사용 후): 기존 화면을 안지워지고 남아있음(백번 푸쉬하면 백번 공간을 차지하는 상태) : "메모리 누수" 발생 : 개발자가 코드를 잘못 작성해서 메모리 공간을 계속 차지하는 경우

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    

}
