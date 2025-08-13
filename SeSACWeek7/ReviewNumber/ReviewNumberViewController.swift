//
//  ReviewNumberViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import UIKit
import SnapKit

class ReviewNumberViewController: UIViewController {
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "₩0"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private let convertedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let viewModel = ReviewNumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureActions()
        bindData()
        
        
        // 반응형? :
        var a = ReviewObservable(1)
        var b = ReviewObservable(2)
        
        //a가 달라지는 시점이 하고싶은 기능을 넣어서 바인드로 보내줌
        a.bind { //이거 자체가 반응형: a의 변화에 따라 달라지는
            print(a.value + b.value)
        }
        b.bind { //이거 자체가 반응형: a의 변화에 따라 달라지는
            print(a.value + b.value)
        }
                
        a.value = 3 //데이터가 바뀌면 (뷰는 따로 놀아서) 맞춰줘야 한다.
        a.value = 60
        b.value = 3000 //감지 안됨

        
    }
    
    func bindData() {
        
//        viewModel.outputAmount.bind {
        viewModel.output.amount.bind {
//            print("outputAmount 달라짐", self.viewModel.outputAmount.value)
            print("outputAmount 달라짐", self.viewModel.output.amount.value)
//            self.formattedAmountLabel.text = self.viewModel.outputAmount.value //처음에는 초기값인 빈 값이 실행되서 아무것도 안보임
            self.formattedAmountLabel.text = self.viewModel.output.amount.value
        }
        
    }
    
    
    @objc private func amountChanged() {
        print(#function)
        
//        viewModel.inputAmount.value = amountTextField.text //양쪽다 옵셔널 스트링: 타입 일치
        viewModel.input.amount.value = amountTextField.text

    }
    
    func showAlert() {
        
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        
        
        let open = UIAlertAction(title: "확인", style: .default) { _ in
           
        }
        
        let delete = UIAlertAction(title: "삭제",
                                   style: .destructive)
        
        let cancel = UIAlertAction(title: "취소",
                                   style: .cancel)
        
        
        alert.addAction(cancel)
        alert.addAction(delete)
        alert.addAction(open)
        
        
        present(alert, animated: true)
        
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
        view.addSubview(convertedAmountLabel)
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
        
        convertedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(formattedAmountLabel.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }
    
    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
    }
}
