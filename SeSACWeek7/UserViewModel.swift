//
//  UserViewModel.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/8/25.
//

import Foundation


// 역할과 범위
//"M""V""VM"(모델, 뷰컨, viewModel(뷰에 보여질 최종적인 뷰))



//UserViewModel는 UI와 상관 없는 영역이여서 UIKit을 import하지 않는다.
class UserViewModel {
    
    //
    var list: [Person] = [] {
        didSet {
            print(oldValue) //예전 데이터보여줘
            print(list) //변화된 데이터 보여줘
             
            //여기서는 tableView.reloadData() 이거 못하는데 어떡하지? : 테이블뷰를 여기 뷰모델에서는 인식 못하니까 뷰컨에서 구성을 해줘야 함 : "클로저" 활용
            //뷰컨에서 이 코드를 작성하는게 맞겠다(값전달을 그대로 활용) : 어쩔수없이 작성 못하는 코드는 값전달(클로저)를 활용
            //핀님한테 자랑해야지~
            //예전에 클로저 처음 배울 때 매개변수로 굳이 왜 함수를 보내나 했었는데..: 그 이유가 이렇게 기능을 파일별로 분리를 할때 : 파일별로 뷰컨이 담당할 수 있는 기능(ex.테이블뷰 갱신같은), 뷰모델이 담당할 기능(계산같은 로직들)이 나눠져 있기 때문에 : 자기 파일에서 담당할 수 없는 기능을 내쪽에서 사용해야 할때 "값전달" 형태를 빌려, 함수 내용(나는 담당할 수 없는 기능을 가진:여기선 테이블뷰 갱신)을 받을 수 있는 빈함수를 갖는 클로저(그릇)를 만들어두고 저쪽 다른 파일에서 함수내용을 뷰디드로드에서 보내주면 나는 내가 실행하고 싶을 때 함수를 실행시켜서 활용하는 것이었음 (값전달 방식처럼)
            
            reload?() //list가 "달라졌을 때" 실행을 시켜주고 싶은 것
            
        }
    }
    
    
    
    //이 뷰모델의 프로퍼티를 하나 만들어보자: 갱신할 수 있는 기능을 갖는
    var reload: (() -> Void)? //함수를 옵셔널로 갖고 있는 형태 //뷰컨에서 값전달 받아야해: 빌드하면 뷰컨의 뷰디드로드에서 받은 함수 내용을 갖고서 "대기"함: 그러다 버튼을 눌러서 데이터의 변화가 생기면 위에 didset에서 reload를 실행시켜줌으로서 대기하고 있던 클로저의 내용(테이블뷰갱신해달라)이 실행되어 버튼이 정상작동
    
    
    
    //UserViewModel 이 친구가 인스턴스가 생성이 되는 시점을 찍어보자
    init() {
        print("UserViewModel이 Inint이 됐다")
        //씬델리게이트에서 UserViewController()로 만들어질때
        //클래스가 가지고 있는 모든 프로퍼티들이 초기화가 되어야 뷰컨이 만들어질 수 있어: 갖고 있는 프로퍼티들 중에 UserViewModel도 초기화가 되고 있구나 : 빌드시 처음에 뷰컨이 커질때 시작과 같이 초기화됨
        
        load() //로드함수 실행 시켜서 데이터가 추가
        
    }
    
    
    //-----------------------------

    
    
    
    
    //뷰컨에서 로드버튼을 눌렀다는 "사실만" 전달해주는 기능을 만들자 : didset 적용
    var loadTapped =  0 { //인트같은 작은 단위 데이터로 트리거를 전달을 받자 //다른 int를 받는것만으로도 didset이 적용이 됨!
        
        didSet {
            print("loadTapped")
            load() //신호가 왔으니 실행
        }
    }
    var resetTapped = () { //트리거만 주면 되지 실질적인 내용은 상관 없으므로 암거나 : ()로도 가능함
        
        didSet {
            print("resetTapped")
            reset()
        }
    }
    var addTapped = true {
        
        didSet {
            print("addTapped")
            add()
        }
    }
    
    //-----------------------------
    
    
    
    //기능별 함수를 만들어서 다 가져오자
    private func load() { //private까지 해줘야 뷰컨이 진짜 이 안에 무슨 내용이 있는지 몰라 : 
        
        list = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
        
    }
    
    private func reset() {
        
        list.removeAll() //데이터의 변화가 감지
    }
    
    private func add() {
        
        let jack = Person(name: "Jack", age: Int.random(in: 1...100))
        list.append(jack) //데이터의 변화가 감지
    }
       
    
    
    //최종적으로 보여줄 데이터만 보내줌
    func cellForRowAtData(indexPath: Int) -> String {
        
        let data = list[indexPath]
        return "\(data.name), \(data.name)세"
        
    }
    
}
