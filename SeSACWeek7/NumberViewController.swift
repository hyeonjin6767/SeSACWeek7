//
//  NumberViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/8/25.
//

import UIKit
import SnapKit

class NumberViewController: UIViewController {
    
    
    let viewModel = NumberViewModel()
    

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "값을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureActions()
        
        
//        viewModel.closureText = {
//            self.formattedAmountLabel.text = self.viewModel.outputText
//        }
//        viewModel.outputText.playAction {
//            self.formattedAmountLabel.text = self.viewModel.outputText.text
//        }
        viewModel.outputText.playAction { text in
            self.formattedAmountLabel.text = text
        }
        
        
        //두번째 연습
        //인스턴스를 만들었기 때문에 init이 프린트되었고
        let sesac = ObservableExercise("새싹") //외부매개변수 생략해서 바로 스트링 값을 쓸 수 있는 형태 : 첫값만 넣어준거라 didset이 실행되진 않아
        
        sesac.text = "안녕하세요" //값이 변경되서 didset이 첫 호출
        //여기까진 action이라는 프로퍼티에 어떤 기능도 넣어주지 않았기 때문에 실행할게 없어
/*
        sesac.action = { //이때의 액션은 프로퍼티에 넣어주는거고
            print("액션에 기능을 넣어주기")
            self.view.backgroundColor = .yellow
        } //이 액션을 실행시켜주기 위해선 아래에서 값을 한번더 변경 시켜줘야함: 실행시켜줄 방법1.값 변경, 방법2. 의도적으로 어떤 시점에 실행 -그래서 함수 내용을 넣어주고 실행시켜주는것까지 한번의 하나의 메서드로 만들어보자: 위아래줄 합쳐서 playAction함수 만들기
        sesac.action?()
*/
        sesac.text = "값이 바뀌어야 이전에 들어갔던 액션이 실행됨"
        sesac.playAction { _ in // 축약형 : 지금은 매개변수에 함수를 넣어주는 거라 등호가 없음 주의(자동완성)
            print("액션에 기능을 넣어주면서 실행도 시키기")
            self.view.backgroundColor = .yellow
        }
//        sesac.playAction(play: { // 축약안된버전: 위아래 같은 의미
//            print("액션에 기능을 넣어주기")
//            self.view.backgroundColor = .yellow
//        })
        sesac.text = "텍스트 변경"
        sesac.text = "텍스트 또변경"

        
        
        //테스트
        let jack = Observable(text: "jack") //값이 변경된건 아니고 이니셜라이즈 된거라 didset이 실행되진 않고 init구문만 출력됨
        
//        jack.hello = {
//            print("첫번째 헬로") //직전(기존)에 클로저에 들어있던 내용이 실행
//        }
//        jack.hello?() //의도적으로 원하는 시점에 실행시켜줄 수도 있어 : 근데 이 두개를 하나의 바인드(전달도 해주고 실행도 시켜줌)로 묶어보자
        //위 두줄 합치기
//        jack.bind { //매개변수에 넣어주는 형태라 =(부등호)가 없는 거 주의!
//            print("첫번째 헬로") //매개변수로 클로저로 내용을 넣어주고 넣어주자마자 실행 및 헬로에도 넣어줌
//        }
        jack.bind { _ in //매개변수에 넣어주는 형태라 =(부등호)가 없는 거 주의!
            print("첫번째 헬로") //매개변수로 클로저로 내용을 넣어주고 넣어주자마자 실행 및 헬로에도 넣어줌
        }
        //위아래 같은 의미
//        jack.bind(closure: {
//            print("첫번째 헬로")
//        })
        
        jack.value = "finn" //값이 바뀌어야 이전에 들어갔던 헬로가 실행됨
        
        
//        jack.hello = {
//            print("두번째 헬로") //직전(기존)에 클로저에 들어있던 내용이 실행
//        }
        
//        jack.hello = {
//            print("첫번째 헬로") //직전(기존)에 클로저에 들어있던 내용이 실행
//        }
//
        jack.value = "Den"
        
//        jack.hello = {
//            print("세번째 헬로") //얘는 왜 실행이 안될까?, 실행하려면 어떻게 해야할까? : 헬로에 들어가 있긴 한데 값의 변화가 없어서 두번째 헬로까지밖에 실행이 되지 않았던것 :  그렇다면 어떻게 실행?(1.값 변경방법 or 2.의도적으로 원하는 시점에 실행 : 근데 이 2개를 합쳐서 이것 또한 함수로 만들어버림!: 이게 bind함수)
//        }
//
        
    }
    
    //amountChanged가 매번 호출되는거 뷰컨인 내가 왜 해야되냐 : 뷰모델 너가 해
    
 
    @objc private func amountChanged() {
        print(#function)
        
        viewModel.inputField.text = amountTextField.text!
        
        //나는 텍스트필드에 "입력된 글자"그자체를 뷰모델로 전달 : 그전에는 데이터 변경 신호용으로 아무 의미 없는 값 아무거나 보냈다면 이번엔 글자 값 자체를 보냄 //값의 변경 "신호"를 amountTextField 입력값으로 전달한 것
//        viewModel.inputField = amountTextField.text! //여기서 옵셔널 처리를 하지 않고 단순히 전달만 하자 : 뷰컨이 옵셔널 처리도 할 필요 없다고 판단.: 대신 저쪽에 신호를 받는 inputField를 옵셔널 타입으로 이렇게  var inputField: String? 지정
        
        
        //        //1) 옵셔널
        //        guard let text = amountTextField.text else {
        //            formattedAmountLabel.text = ""
        //            formattedAmountLabel.textColor = .red
        //            return
        //        }
        //
        //        //2) Empty
        //        if text.isEmpty {
        //            formattedAmountLabel.text = "값을 입력해주세요"
        //            formattedAmountLabel.textColor = .red
        //            return
        //        }
        //
        //        //3) 숫자 여부
        //        guard let num = Int(text) else {
        //            formattedAmountLabel.text = "숫자만 입력해주세요"
        //            formattedAmountLabel.textColor = .red
        //            return
        //        }
        //
        //        //4) 0 - 1,000,000
        //        if num > 0, num <= 1000000 {
        //
        //            let format = NumberFormatter()
        //            format.numberStyle = .decimal //3글자 단위마다 쉼표
        //            let result = format.string(from: num as NSNumber)!
        //            formattedAmountLabel.text = "₩" + result
        //            formattedAmountLabel.textColor = .blue
        //        } else {
        //            formattedAmountLabel.text = "백만원 이하를 입력해주세요"
        //            formattedAmountLabel.textColor = .red
        //        }
        //    }
    }
}

extension NumberViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
    }

    private func configureConstraints() {
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        formattedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }

    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged) //editingChanged:글자가 달라질때마다
    }

}
