//
//  ARCViewController.swift
//  SeSACWeek7
//
//  Created by 박현진 on 8/14/25.
//

import UIKit

class ARCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print("ARCViewController viewDidLoad")

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = DetailViewController() //클래스의 인스턴스가 생성된다는것은 이니셜라이즈가 실행된다는 것
        navigationController?.pushViewController(vc, animated: true)
    }

    init() {
        super.init(nibName: nil, bundle: nil) //부모클래스의 인잇을 호출해줘야함(상속받는애가 있어서)
        print("ARCViewController Init")
        
    }
    
    //인잇이 사라지는 시점을 알려주는 deinit : 화면전환시 필요없어지면 메모리 공간에서 없앴다가 다시 만들었다가 하는.: 필요없는 공간은 그때그때 소거해줌
    //deinit만 잘 실행되면 메모리 공간을 낭비할 일은 없어
    deinit {
        print("ARCViewController deinit")

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
   
}
