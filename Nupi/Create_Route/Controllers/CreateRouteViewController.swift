//
//  CreateRouteViewController.swift
//  Nupi
//
//  Created by Dana Lim on 2/13/25.
//

import UIKit
import FSCalendar

class CreateRouteViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let createRouteView = CreateRouteView()
    private var selectedImages: [UIImage] = [] // 추가된 이미지 저장 배열

    override func loadView() {
        self.view = createRouteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FSCalendar 설정
        createRouteView.calendar.dataSource = self
        createRouteView.calendar.delegate = self
        createRouteView.calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase

        // UICollectionView 설정
        createRouteView.placeCollectionView.dataSource = self
        createRouteView.placeCollectionView.delegate = self
    }

    // UIImagePickerController 실행 함수
    private func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true  // 선택한 사진 편집 가능
        present(imagePicker, animated: true)
    }

    // 사용자가 사진을 선택했을 때 호출됨
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            // 8개까지 추가 가능
            if selectedImages.count < 8 {
                selectedImages.insert(selectedImage, at: 0) // 최근 사진이 맨 앞에 추가
            }
            createRouteView.placeCollectionView.reloadData()
            updateCollectionViewHeight() // 높이 업데이트 호출
        }
    }

    // 사용자가 사진 선택을 취소했을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// UICollectionView Delegate & DataSource
extension CreateRouteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(selectedImages.count + 1, 8)  // `+` 버튼 포함
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == selectedImages.count {
            // `+` 버튼이 마지막 위치
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoCell.identifier, for: indexPath) as! AddPhotoCell
            
            if selectedImages.count == 8 {
                // 8개 추가 완료 시 `+` 버튼 비활성화 & 반투명 효과
                cell.addButton.isEnabled = false
                cell.addButton.alpha = 0.5 // 반투명
                cell.addButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            } else {
                // 기본 상태
                cell.addButton.isEnabled = true
                cell.addButton.alpha = 1.0
                cell.addButton.backgroundColor = .blue1.withAlphaComponent(0.2)
            }
            
            cell.addButton.addTarget(self, action: #selector(addPhotoTapped), for: .touchUpInside)
            return cell
        } else {
            // 최근 추가된 사진이 왼쪽, 오래된 사진이 오른쪽
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.identifier, for: indexPath) as! PlaceCollectionViewCell
            cell.configure(with: selectedImages[indexPath.item])
            return cell
        }
    }

    // `+` 버튼 클릭 시 이미지 피커 실행
    @objc private func addPhotoTapped() {
        openImagePicker()
    }

    // 셀 크기 설정 (한 줄에 4개 배치)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - (3 * 8)) / 4  // 4개 배치, 간격 8
        return CGSize(width: cellWidth, height: cellWidth)
    }

    // 행 간 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    // 아이템 간 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // 사진이 추가될 때마다 UICollectionView의 높이를 자동 조정
    private func updateCollectionViewHeight() {
        let itemCount = selectedImages.count + 1 // `+` 버튼 포함
        let rows = ceil(Double(itemCount) / 4.0) // 4개씩 한 줄에 배치
        let newHeight = CGFloat(rows * 80) + CGFloat((rows - 1) * 8) // 셀 높이 + 간격 반영

        UIView.animate(withDuration: 0.25) { // ✅ 애니메이션 효과 추가
            self.createRouteView.placeCollectionView.snp.updateConstraints { make in
                make.height.equalTo(newHeight)
            }
            self.view.layoutIfNeeded() // 즉시 반영
        }
    }
    // ✅ 셀 터치 시 삭제 기능 추가
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < selectedImages.count {  // ✅ `+` 버튼이 아닌 경우만 삭제
            selectedImages.remove(at: indexPath.item)
            collectionView.reloadData()
        }
    }
}
