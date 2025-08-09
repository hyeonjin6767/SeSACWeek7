//
//  NumberViewModel.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/8/25.
//

import Foundation

class NumberViewModel {
    
    
    //뷰컨에서 뷰모델로 들어오는 정보
    var inputField: String? = ""  { //String?로 옵셔널 처리를 여기서 하는 이유는 뷰모델이 이 옵셔널 처리도 뷰모델이 맡아서 해야한다고 생각함: 뷰컨이 할게 아니라
        
        didSet {
            print("inputField로 입력값 전달 받아서 데이터 변화 신호 옴")
            print(oldValue)
            print(inputField)
            validate()
        }
    }
    
    
    //뷰컨에 뷰디드로드에서 함수내용을 보내줘서 담아두고 기다리고 있다가~ 아래 outputText에서 조건에 따라 실행시켜주면 그때 실행됨
    var closureText: (() -> Void)?
    
    
    //뷰모델에서 뷰컨으로 보내줄 최종 정보가 두가지(텍스트, 컬러)
    var outputText = "" {
        didSet { //아래 validate에서 변화가 있는지 이것도 확인
            print("outputText")
            print(oldValue)
            print(outputText)
            //label.text = outputText //이거를 최종적으로 하고 싶은데 여기선 못하니까 위에 closureText 클로저 활용
            //closureText 안에 내용은 모르겠지만~ outputText의 글자가 달라지면은 실행을 해줘
            closureText?()
        }
    }
    //개발자별로 그냥 uikit임포트해버리자(이건 지양하자) 혹은 색상명을 String으로 받자 혹은 Bool값으로 받자 각자 스타일대로
    //false면 red, true면 blue
    var outputColor = false {
        didSet {
            print("outputColor")
            print(oldValue)
            print(outputColor)
            //label.textColor = outputColor == false ? .red : .blue //이거를 최종적으로 하고 싶은데 여기선 못하니까 위에 closureText 클로저 활용
        }
    }
    
    private func validate() {
        
        //1) 옵셔널
        guard let text = inputField else {
            //formattedAmountLabel.text = ""
            outputText = ""
            
            //formattedAmountLabel.textColor = .red
            outputColor = false
            return
        }
        
        //2) Empty
        if text.isEmpty {
            //formattedAmountLabel.text = "값을 입력해주세요"
            outputText = "값을 입력해주세요"
            
            //formattedAmountLabel.textColor = .red
            outputColor = false
            
            return
        }
        
        //3) 숫자 여부
        guard let num = Int(text) else {
            //formattedAmountLabel.text = "숫자만 입력해주세요"
            outputText = "숫자만 입력해주세요"
            
            //formattedAmountLabel.textColor = .red
            outputColor = false
            
            return
        }
        
        //4) 0 - 1,000,000
        if num > 0, num <= 1000000 {
            
            let format = NumberFormatter()
            format.numberStyle = .decimal //3글자 단위마다 쉼표
            let result = format.string(from: num as NSNumber)!
            
            //formattedAmountLabel.text = "₩" + result
            outputText = "₩" + result
            
            //formattedAmountLabel.textColor = .blue
            outputColor = true
        } else {
            //formattedAmountLabel.text = "백만원 이하를 입력해주세요"
            outputText = "백만원 이하를 입력해주세요"
            
            //formattedAmountLabel.textColor = .red
            outputColor = false
            
        }
    }
    
}
