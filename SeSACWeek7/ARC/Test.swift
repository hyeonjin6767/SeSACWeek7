//
//  Test.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/14/25.
//

import Foundation





//ARC playground 복붙
//"weak의 활용 예시"
//커스텀뷰를 사용하는 상황을 "가정": 우리가 만든 MyDelegate라는 이름의 프로토콜을 활용한 메인에서 디테일로 값전달해보자






protocol MyDelegate: AnyObject { //AnyObject를 붙이면 클래스에서만 사용가능한 프로토콜이 됨!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    func sendData()
}


class MainVC: MyDelegate {
   
    func sendData() {
        print("sendData 정의 안해줘서 난 에러 방지용 프린트")
    }
    
    
    lazy var customView = { //즉시실행함수
        let view = DetailView() //디테일뷰의 인스턴스를 사용
        
        //"우리가 사용하면 tableView.delegate = self같은 예시" : 여기서도 self를 잘못 사용하면 RC+1이 되어서 deinit이 실행되지 않을 수 있어: weak로 해결
        view.jack = self // jack은 우리가 사용하던 델리게이트나 데이터소스같은 프로토콜이라고 생각하면 됨
        return view
    }()
    
    func sendDate() { //데이터 전달이나 로직을 수행할 수 있는 메서드가 있다고 가정하자
        print("안녕하세요")
    }
    deinit { //deinit이 잘되는지 체크
        
        print("MainVC deinit")
    }
}

class DetailView {
    
//    var jack: MainVC? //너무 큰 친구를 데려오다보니 찝찝하니까 프로토콜을 활용해보자
//    var jack: MyDelegate? //jack이라는 프로퍼티에다가 MyDelegate라는 프로토콜을 타입으로 선언을 해줌
    weak var jack: MyDelegate? //우리가 프로토콜을 만들어서 활용하던 이 상황에서 여태까지는 변수만 사용했는데 앞에 weak 추가!!!!!!!!!!!!!!!!!!!! : 근데 문제 발생
    //weak라는 애는 : 클래스의 인스턴스나 참조 타입을 해결해주기 위해 나온 키워드 : 근데 우리가 만든 MyDelegate라는 프로토콜은 구조체, 열거형, 클래스에서도 다 쓸 수 있는 애라 MyDelegate에 weak를 쓰는게 허용이 안됨 : AnyObject를 통해서 "클래스에서만" 사용가능한 프로토콜이다 라고 지정을 해줘야 함
    //우리가 여태 사용하던 UIScrollViewDelegate같은 프로토콜 모두 정의를 타고타고 들어가다 보면 "AnyObject로 클래스에만 사용가능한 프로토콜"로 만들어져 있어서 weak를 쓸 수 있는거였고(이미 애플이 weak로 만들어놔서) 우리가 쓰던 즉시실행함수의 tableView.delegate = self, tableView.datasource = self 이런 애들은 메모리 관련 문제가 되지 않았던 것.

    
    func dismiss() { //받아온 프로토콜을 통해서 sendData를 호출 가능
        jack!.sendData() // sendData는 우리가 프로토콜 채택해서 그 안에 있던 didlselectRowAt이나 CellForRowAt같은 친구라고 생각하면됨
    }
    
    deinit {
        
        print("DetailVC deinit")

    }
}

//var view: MainVC? = MainVC()
//view = nil //필요없어져서 닐로 없앤다고 가정하면 디인잇이 실행될것

