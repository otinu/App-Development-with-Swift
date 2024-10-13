//
//  ViewController.swift
//  ColorMix
//
//  Created by Apple on 2024/10/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redSwitch: UISwitch!
    @IBOutlet weak var blueSwitch: UISwitch!
    @IBOutlet weak var greenSwitch: UISwitch!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 枠線を表示
        colorView.layer.borderWidth = 5
        colorView.layer.cornerRadius = 20
        colorView.layer.borderColor = UIColor.black.cgColor
        
        // 初回アクセス時、デフォルトのupdateColor()呼び出し
        updateColor()
        
        updateControls()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        // ユーザー操作ごとにupdateColor() 呼び出し
        updateColor()
        
        updateControls()
    }
    
    func updateColor() {
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        if redSwitch.isOn {
            red = CGFloat(redSlider.value)
        }
        
        if blueSwitch.isOn {
            blue = CGFloat(blueSlider.value)
        }
        
        if greenSwitch.isOn {
            green = CGFloat(greenSlider.value)
        }
        
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        colorView.backgroundColor = color
    }
    
    // スライダー固定
    func updateControls() {
        redSlider.isEnabled = redSwitch.isOn
        blueSlider.isEnabled = blueSwitch.isOn
        greenSlider.isEnabled = greenSwitch.isOn
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        updateColor()
    }
    
    @IBAction func reset(_ sender: Any) {
        redSwitch.isOn = false
        blueSwitch.isOn = false
        greenSwitch.isOn = false
        redSlider.value = 1
        blueSlider.value = 1
        greenSlider.value = 1
        
        updateColor()
        updateControls()
    }
}

