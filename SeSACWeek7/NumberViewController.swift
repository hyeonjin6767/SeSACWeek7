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
        
        
        viewModel.closureText = {
            self.formattedAmountLabel.text = self.viewModel.outputText
        }
        
        
    }
    
    //amountChanged가 매번 호출되는거 뷰컨인 내가 왜 해야되냐 : 뷰모델 너가 해
    
 
    @objc private func amountChanged() {
        print(#function)
        
        
        
        //나는 텍스트필드에 "입력된 글자"그자체를 뷰모델로 전달 : 그전에는 데이터 변경 신호용으로 아무 의미 없는 값 아무거나 보냈다면 이번엔 글자 값 자체를 보냄 //값의 변경 "신호"를 amountTextField 입력값으로 전달한 것
        viewModel.inputField = amountTextField.text //여기서 옵셔널 처리를 하지 않고 단순히 전달만 하자 : 뷰컨이 옵셔널 처리도 할 필요 없다고 판단.: 대신 저쪽에 신호를 받는 inputField를 옵셔널 타입으로 이렇게  var inputField: String? 지정
        
        
        
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
