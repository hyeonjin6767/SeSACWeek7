//
//  LoginViewModel.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/11/25.
//

import Foundation


class LoginViewModel {
    
    //뷰컨에서 뷰모델로 전달해줄 글자 : 뷰컨에서 들어온 이벤트
    var inputIdTextFieldText = ObservableExercise("")
    //외부로 보내줄 데이터들
    var outputValidationLabel = ObservableExercise("") //레이블의 글자용
    var outputTextColor = ObservableExercise(false) //레이블의 컬러용
    
    
    init() {
        print("LoginViewModel init")
        
//        inputIdTextFieldText.bind {
//            self.validation()
//        }
        
//        inputIdTextFieldText.playAction {
//            self.validation() //playAction의 매개변수에 validation라는 함수 넣어주기
//        }
        inputIdTextFieldText.playAction { _ in
            self.validation()
        }
    }
    
    private func validation() {
        if inputIdTextFieldText.text.count < 4 {
            outputValidationLabel.text = "4자리 미만입니다"
            outputTextColor.text = false
        } else {
            outputValidationLabel.text = "잘했어요"
            outputTextColor.text = true
        }
    }
}
