//
//  EffectViewController.swift
//  MyCamera
//
//  Created by pco2699 on 2017/06/10.
//  Copyright © 2017年 pco2699. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {
  var originalImage: UIImage?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    effectImage.image = originalImage
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  @IBOutlet weak var effectImage: UIImageView!
  @IBAction func effectButtonAction(_ sender: Any) {
    // フィルター名を指定
    let filterName = filterArray[filterSelectNumber]
    
    // 次の選択するエフェクト添字に更新
    filterSelectNumber += 1
    
    // 添字が配列の数と同じか？チェック
    if filterSelectNumber == filterArray.count {
      // 同じ場合は最後まで選択されたので先頭に戻す
      filterSelectNumber = 0
    }
    
    // もともとの画像の回転角度を取得
    let rotate = originalImage!.imageOrientation
    
    // UIImage形式の画像をCIImage形式の画像に変換
    let inputImage = CIImage(image: originalImage!)
    
    // フィルターの種類を引数で指定された種類を指定してCIFilterのインスタンスを取得
    let effectFilter = CIFilter(name: filterName)!
    
    // エフェクトのパラメータを初期化
    effectFilter.setDefaults()
    
    // インスタンスにエフェクトする元画像を設定
    effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
    
    // エフェクト後のCIImage形式の画像を取り出す
    let outputImage = effectFilter.outputImage
    
    // CIContextのインスタンスを取得
    let ciContext = CIContext(options: nil)
    
    // エフェクト後の画像をCIContext上に描画し、結果をcgImageとしてCGImage形式の顔像を取得
    let cgImage = ciContext.createCGImage(outputImage!, from: outputImage!.extent)
    
    // エフェクト後の画像をCGImage形式の画像からUIImage形式の画像に回転角度を指定して変換しImageViewに表示
    effectImage.image = UIImage(cgImage: cgImage!, scale: 1.0, orientation: rotate)
  }
  @IBAction func shareButtonAction(_ sender: Any) {
    let controller = UIActivityViewController(activityItems: [effectImage.image!], applicationActivities: nil)
    
    // iPadで落ちてしまう対策
    controller.popoverPresentationController?.sourceView = view
    
    // UIActivityViewCOntrollerを表示
    present(controller, animated: true, completion: nil)
  }
  @IBAction func closeButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  let  filterArray = [ "CIPhotoEffectMono",
                       "CIPhotoEffectChrome",
                       "CIPhotoEffectFade",
                       "CIPhotoEffectInstant",
                       "CIPhotoEffectNoir",
                       "CIPhotoEffectProcess",
                       "CIPhotoEffectTonal",
                       "CIPhotoEffectTransfer",
                       "CISepiaTone"]
  // 選択中のエフェクト添字
  var filterSelectNumber = 0
		
  
  
}
