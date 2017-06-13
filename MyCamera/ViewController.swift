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
//    // カメラが利用可能かチェック
//    if UIImagePickerController.isSourceTypeAvailable(.camera){
//      print("カメラは利用できます")
//      // (1) UIImagePickerControllerのインスタンスを作成
//      let ipc = UIImagePickerController()
//      // (2) sourceTypeにCameraを設定
//      ipc.sourceType = .camera
//      // (3)delegate設置
//      ipc.delegate = self
//      // (4)モーダルビューで表示
//      present(ipc, animated: true, completion: nil)
//    }
//    else {
//      print("カメラは利用できません")
//    }
    // カメラかフォトライブラリーどちらから画像を取得するか選択
    let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
    
    // カメラが利用可能かチェック
    if UIImagePickerController.isSourceTypeAvailable(.camera){
      // カメラを起動するための選択肢を定義
      let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {(action:UIAlertAction) in
        // カメラを起動
        let ipc : UIImagePickerController = UIImagePickerController()
        ipc.sourceType = .camera
        ipc.delegate = self
        self.present(ipc, animated: true, completion: nil)
      })
      alertController.addAction(cameraAction)
    }
    
    // フォトライブラリーが利用可能かチェック
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
      // フォトライブラリーを起動するための選択肢を定義
      let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action: UIAlertAction) in
        // フォトライブラリーを移動
        let ipc : UIImagePickerController = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        self.present(ipc, animated: true, completion: nil)
      })
      alertController.addAction(photoLibraryAction)
    }
    // キャンセルの選択肢を定義
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    // iPadで落ちてしまう対策
    alertController.popoverPresentationController?.sourceView = view
    
    // 選択を画面に表示
    present(alertController, animated: true, completion: nil)
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
    captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
    // (3)モーダルビューを閉じる
    dismiss(animated: true, completion: {
      // (4)エフェクト画面に遷移
      self.performSegue(withIdentifier: "showEffectView", sender: nil)
    })
  }
  
  var captureImage: UIImage?
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let nextViewController = segue.destination as! EffectViewController
    nextViewController.originalImage = captureImage
  }

}

