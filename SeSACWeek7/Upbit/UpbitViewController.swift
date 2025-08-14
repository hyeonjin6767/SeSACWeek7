//
//  UpbitViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import UIKit
import SnapKit

class UpbitViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
      
    let viewModel = UpbitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItems()
        bindData()
    }
    

//    override func viewDidAppear(_ animated: Bool) { //"화면이 뜰때 마다" 왔다갔다 하도록
//        super.viewDidAppear(animated)
//        
//        
//    }
    
    func bindData() {

//        viewModel.inputViewDidLoadTrigger.value = () //가장 작은단위 빈 튜플로 신호만 전달
        viewModel.input.viewDidLoadTrigger.value = ()
//        viewModel.outputMarketData.bind {
//                print("list 변경", self.viewModel.outputMarketData.value)
//        } // 없어도 데이터는 잘 보임
//        viewModel.outputMarketData.bind {
        viewModel.output.marketData.bind {
            print("viewController outputMarketData")
            print("list 변경", self.viewModel.output.marketData.value)
            self.tableView.reloadData()
        }
//        viewModel.outputNavigationTitleData.bind {
        viewModel.output.navigationTitleData.bind {
            print("viewController outputNavigationTitleData")
//            let value = self.viewModel.outputNavigationTitleData.value
            let value = self.viewModel.output.navigationTitleData.value
            self.navigationItem.title = value
        }
        
        
        
        //여기도 중복 호출 - lazybind로 해결 혹은, 옵셔널이거나 빈값일 때는 실행되지 않도록 early exit를 하거나: 조건문 활용할수도
        viewModel.output.cellSelected.bind {
            print("viewController outputCellSelected")
            //화면전환 뿐만아니라 전달 받은 데이터도 확인 가능
            print("output", self.viewModel.output.cellSelected.value)
            
            if self.viewModel.output.cellSelected.value.isEmpty {
                return //early exit
            }
            
            let vc = UpbitDetailViewController()
            //vc.koreanData = self.viewModel.outputCellSelected.value
            vc.viewModel.outputTitle.value = self.viewModel.output.cellSelected.value //서로의 뷰컨의 뷰모델들끼리 값전달
            self.navigationController?.pushViewController(vc, animated: true)
        }

//        viewModel.outputCellSelected.lazyBind {
//            
//            //화면전환 뿐만아니라 전달 받은 데이터도 확인 가능
//            print("output", self.viewModel.outputCellSelected.value)
//
//            let vc = UpbitDetailViewController()
//            //vc.koreanData = self.viewModel.outputCellSelected.value
//            vc.viewModel.outputTitle.value = self.viewModel.outputCellSelected.value //서로의 뷰컨의 뷰모델들끼리 값전달
//            self.navigationController?.pushViewController(vc, animated: true)
//        } 
//        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
         
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupNavigationItems() {
        navigationItem.title = "마켓 목록"
    }
}

extension UpbitViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.outputMarketData.value.count
        return viewModel.output.marketData.value.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
//        let row = viewModel.outputMarketData.value[indexPath.row]
        let row = viewModel.output.marketData.value[indexPath.row]

        
//        cell.textLabel?.text = "\(row.korean_name) | \(row.english_name)"
        cell.textLabel?.text = row.overView

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
//        let vc = UpbitDetailViewController()
//        navigationController?.pushViewController(vc, animated: true)
//        
//        viewModel.inputCellSelectedTrigger.value = () //빈 값을 줘서 셀이 선택되었다는 "트리거만" 전달
        
//        let row = viewModel.outputMarketData.value[indexPath.row]
//        viewModel.inputCellSelectedTrigger.value = row //"트리거와 값전달"도 함께 전달

        let row = viewModel.output.marketData.value[indexPath.row]
        viewModel.input.cellSelectedTrigger.value = row //"트리거와 값전달"도 함께 전달
    }
    
}
