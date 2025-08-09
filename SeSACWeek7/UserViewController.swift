//
//  UserViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/8/25.
//

import UIKit
import SnapKit


//import UIKit의 영역을 빼봐라 :
// 에러가 안나는 영역 체크 : 문제가 안생기는 영역들이 뷰컨이 꼭 관리 안해도되는 애들인거니까 여기서 관리 안해도 된다는 뜻





class UserViewController: UIViewController {

    
    //UserViewModel은 클래스니까 인스턴스 생성가능하지
    //뷰모델의 인스턴스 생성
    let viewModel = UserViewModel() //뷰컨은 갖다주면 보여만 줄께
    
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 60
        table.register(UITableViewCell.self, forCellReuseIdentifier: "PersonCell")
        return table
    }()
    
    private let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loadButton, resetButton, addButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    
    
    //옮겨보고 에러가 발생하냐 안하냐로 체크
    
    
    // "didSet의 개념"
    
    //인스턴스 저장 프로퍼티(등호가 있으면 저장 프로퍼티) , 겟 셋이 있으면 연산 프로퍼티
    //didSet: 저장프로퍼티이던 연산프로터피이던 변화를 알수 있는 구문
    //지금은 저장 프로퍼티의 변화를 알 수 있게 만듬
    
//    var list: [Person] = [] {
//        didSet {
//            
////            print("list 데이터가 달라졌어요")
////            print(oldValue)
////            print(list)
//            
//            tableView.reloadData() //"리스트에 변화가 생기면 갱신해줘"가 되는 것 : 여태 아래 각각3개 쓰던것 안해도됨 : 까먹어서 문제 생기는 것 줄어듬
//        }
//    }
//     
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTableView()
        setupActions()
        
        
        
        
        
        viewModel.reload = {
            //이러한 함수 내용을 보내주자
            print("reload 클로저 실행")
            self.tableView.reloadData()
            //뷰모델이 갖고 있는 리로드함수에 함수 내용(갱신해달라)을 보내줘 : 테이블뷰를 갱신해달라는 함수의 내용을 보내줌: 클로저(함수 내용을 보내줌) //리로드라는 함수에 이 내용이 들어가게
        }
        
        
    }
     
    
    
    //데이터가 바뀌면 테이블뷰가 갱신을 해야 한다.
    //tableView.reloadData()가 3개...

    
    
    //list가 변화가 생겼다는 신호를 받을 수는 없나? : "Property Observer" :리스트를 계속 관찰하다가 변화를 감지
    
    //"Property Observer"
    
    //didSet(변화가 생긴 직"후")/ willSet(변화가 생긴 직"전")

    
    
    
    
    
    
    @objc private func loadButtonTapped() {
        
        print(#function) //버튼 클릭은 잘되는데 왜 변화가 없을까 : 데이터가 바뀔때 갱신이 안되어서:didset
        
        //viewModel.load() //다 뷰모델 너가 해 : 뷰컨 입장에선 무슨일을 하고 있는 거같긴 한데 어떤 일을 하는지 알수는 없는 형태
        
        
        //신호는 전달하는데 load기능은 뷰컨이 몰라
        //이제 위체처럼 직접적인 호출을 하는게 아니고 아래처럼 신호만 전달
        viewModel.loadTapped = 0 //버튼이 눌렸다는 사실만 아무값으로 전달 : 0에서 0으로 전달해도 메모리의 주소값이 달라진다던가 하는 개념으로 값이 달라진것으로 봄
        
        
//        list = [
//            Person(name: "James", age: Int.random(in: 20...70)),
//            Person(name: "Mary", age: Int.random(in: 20...70)),
//            Person(name: "John", age: Int.random(in: 20...70)),
//            Person(name: "Patricia", age: Int.random(in: 20...70)),
//            Person(name: "Robert", age: Int.random(in: 20...70))
//        ]
        //tableView.reloadData() : 이제 변화가 생기면 알아서 갱신 해줌
    }
    
    @objc private func resetButtonTapped() {
        print(#function)

        //viewModel.reset() //다 뷰모델 너가 해 : 뷰컨 입장에선 무슨일을 하고 있는 거같긴 한데 어떤 일을 하는지 알수는 없는 형태
        //사실상 여태 이렇게 메서드를 호출을 하는 것만으로도 역할이 분리 된다했었는데 : 좀더 실질적으로 역할이 완벽히 분리 되려면..: 뷰컨에서 아예 접근도 안되어야 함
        //private으로 메서드를 만들어야 다른곳에서 아예 접근이 안되서 뷰컨이 load, reset, add함수에서 어떤 일이 일어나는지 알 수 없음!
        //개발자 입장에서 코드를 분리하는 것 이상으로: 정말로 뷰컨이 할일을 줄여주려면 뷰컨에서 load,reset,add버튼을 호출조차 하지 않고 존재하는지 조차도 몰라야 함
        
        //이제 위체처럼 직접적인 호출을 하는게 아니고 아래처럼 신호만 전달
        //신호는 전달하는데 reset기능은 뷰컨이 몰라
        viewModel.resetTapped = () // ()로도 가능
        
        
//        list.removeAll()
        
        //tableView.reloadData()
    }
    
    @objc private func addButtonTapped() {
       
        print(#function)

        //viewModel.add() //private으로 변경해서 여기서 접근불가라 에러 발생
        //다 뷰모델 너가 해 : 뷰컨 입장에선 무슨일을 하고 있는 거같긴 한데 어떤 일을 하는지 알수는 없는 형태
        //신호는 전달하는데 add기능은 뷰컨이 몰라
        //이제 위체처럼 직접적인 호출을 하는게 아니고 아래처럼 신호만 전달
        viewModel.addTapped = true
        
        
//        let jack = Person(name: "Jack", age: Int.random(in: 1...100))
//        list.append(jack)
        
        //tableView.reloadData()
    }
}

extension UserViewController {
    private func setupUI() {
        view.backgroundColor = .white
        title = "Person List"
        
        [buttonStackView, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupActions() {
        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
}
 
extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return list.count
        //그냥 데이터인건지 서버로부터 받아온 더미데이터인건지 뭔지 모르겠고 주면 그거 그대로 보여만 줄께
        return viewModel.list.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        
        
        let data = viewModel.cellForRowAtData(indexPath: indexPath.row)
        cell.textLabel?.text = data
        
        //let person = list[indexPath.row]
        //let person = viewModel.list[indexPath.row]

        
        //cell.textLabel?.text = "\(person.name), \(person.age)세"
        return cell
    }
}
