//
//  PhotoViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class PhotoViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        var searchButtonTapped: ReviewObservable<Void> = ReviewObservable(())
        var textFieldText: ReviewObservable<String?> = ReviewObservable(nil)
        //사진 목록 가져오기
        var fetchButtonTapped: ReviewObservable<Void> = ReviewObservable(())
    }
    struct Output {
        //다양한 방식의 output1. 네트워크 통신으로 받아온 데이터를 그대로 가져오겠다
//        var photo: ReviewObservable<Photo?> = ReviewObservable(nil)
        //방식2. : 즉시 보여줄 데이터가 있을 때
        var overview = ReviewObservable("작가: -, 해상도: -")
        var image: ReviewObservable<URL?> = ReviewObservable(nil) //url로 바꾸는 과정까지 뷰모델이 할일이라고 생각
        //사진 리스트
        var list: ReviewObservable<[PhotoList]> = ReviewObservable([])
    }
    
    init() {
        
        input = Input()
        output = Output()
        
        transform()
    }
    //여기 뷰모델만 알 수 있게 private
    private func transform() {
        
        input.searchButtonTapped.lazyBind {
            print("input searchButtonTapped bind")
            self.getPhoto()
        }
        input.textFieldText.lazyBind {
            print("input textFieldText bind")
        }
        input.fetchButtonTapped.lazyBind {
            self.getPhotoList()
        }
    }
    private func getPhotoList() {
        
        PhotoManager.shared.getPhotoList(api: .list) { photo in
            self.output.list.value = photo
        }
//        PhotoManager.shared.getPhotoList { photo in
//            self.output.list.value = photo
//        }
    }
    
    private func getPhoto() {
        
        guard let text = input.textFieldText.value, let photoId = Int(text), photoId >= 0 && photoId <= 100 else {
            print("0~100 사이의 숫자를 입력해주세요.")
            return
        }
        
        PhotoManager.shared.getOnePhoto(api: .one(id: photoId)) { photo in
            
            let data = "작가: \(photo.author), 해상도: \(photo.width) x \(photo.height)"
            self.output.overview.value = data
            
            let url = URL(string: photo.download_url)
            self.output.image.value = url
            
        }
        
        
//        PhotoManager.shared.getOnePhoto(id: photoId) { photo in
////            self.output.photo.value = photo
//            let data = "작가: \(photo.author), 해상도: \(photo.width) x \(photo.height)"
//            self.output.overview.value = data
//            
//            let url = URL(string: photo.download_url)
//            self.output.image.value = url
//            
//        }
    }
}
