//
//  ViewController.swift
//  MyCamera
//
//  Created by pco2699 on 2017/06/10.
//  Copyright © 2017年 pco2699. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  @IBOutlet weak var pictureImage: UIImageView!
  @IBAction func cameraButtonAction(_ sender: Any) {
    // カメラが利用可能かチェック
    if UIImagePickerController.isSourceTypeAvailable(.camera){
      print("カメラは利用できます")
      // (1) UIImagePickerControllerのインスタンスを作成
      let ipc = UIImagePickerController()
      // (2) sourceTypeにCameraを設定
      ipc.sourceType = .camera
      // (3)delegate設置
      ipc.delegate = self
      // (4)モーダルビューで表示
      present(ipc, animated: true, completion: nil)
    }
    else {
      print("カメラは利用できません")
    }
  }

  @IBAction func SNSButtonAction(_ sender: Any) {
    // 表示画像をアンラップしてシェア画像として取り出し
    if let shareImage = pictureImage.image {
      // UIActivityViewControllerを渡す配列を作成
      let shareItems = [shareImage]
      
      // UIActivityViewContollerにシェア画像を渡す
      let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
      
      // iPadで落ちてしまう対策
      controller.popoverPresentationController?.sourceView = view
      
      // UIActivityViewContollerを表示
      present(controller, animated: true, completion: nil)
      
      
    }
  }
  
  // (1)撮影が終わったときに呼ばれるdelegateメソッド
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    // (2)撮影した写真を、配置したpictureImageを渡す
    pictureImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    // (3)モーダルビューを閉じる
    dismiss(animated: true, completion: nil)
  }

}

