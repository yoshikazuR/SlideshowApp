//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 高橋　義一 on 2021/10/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var scrollBtn: UIButton!
    
    var nowIndex:Int = 0
    var timer: Timer!
    
    var imageArray:[UIImage] = [
            UIImage(named: "sample1")!,
            UIImage(named: "sample2")!,
            UIImage(named: "sample3")!
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = imageArray[nowIndex]
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageCliecked))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageViewController:ImageViewController = segue.destination as! ImageViewController
        if (segue.identifier == "imageViewControl") {
            imageViewController.index = imageArray[nowIndex]
            scrollBtn.setTitle("再生", for: .normal)
        }
    }

    @IBAction func nextSlide(_ sender: Any) {
        changeImage(flag: true)
    }
    @IBAction func backSlide(_ sender: Any) {
        changeImage(flag: false)
    }
    @IBAction func autoSlide(_ sender: Any) {
        if(timer == nil) {
            scrollBtn.setTitle("停止", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImageForSlide), userInfo: nil,  repeats: true)
            backBtn.isEnabled = false
            nextBtn.isEnabled = false
        }else {
            scrollBtn.setTitle("再生", for: .normal)
            timer.invalidate()
            timer = nil
            backBtn.isEnabled = true
            nextBtn.isEnabled = true
        }
    }
    
    @objc func changeImageForSlide() {
        changeImage(flag: true)
    }
    
    @objc func changeImage(flag: Bool) {
        if flag {
            nowIndex += 1
            if (nowIndex == imageArray.count) {
                nowIndex = 0
            }
        }else {
            nowIndex -= 1
            if (nowIndex < 0) {
                nowIndex = imageArray.count - 1
            }
        }
        imageView.image = imageArray[nowIndex]
        
    }
    
    @objc func imageCliecked(){
        print("Tapped on Image")
        self.performSegue(withIdentifier: "imageViewControl", sender: self)
        if timer != nil {
            scrollBtn.setTitle("再生", for: .normal)
            timer.invalidate()
            timer = nil
            backBtn.isEnabled = true
            nextBtn.isEnabled = true
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}

