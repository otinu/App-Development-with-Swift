//
//  ViewController.swift
//  MemeMaker
//
//  Created by Apple on 2024/10/14.
//

import UIKit

class ViewController: UIViewController {
    
    let topChoices: [CaptionOption] = [
        CaptionOption(emoji: "☀️", captionText: "sunny"),
        CaptionOption(emoji: "☁️", captionText: "cloudy"),
        CaptionOption(emoji: "☂️", captionText: "rain")]
    
    let bottomChoices: [CaptionOption] = [
        CaptionOption(emoji: "🏕️", captionText: "Go camping!"),
        CaptionOption(emoji: "🎣", captionText: "Let's fishing!"),
        CaptionOption(emoji: "🏠", captionText: "That's too bad... Stay Home")]

    @IBOutlet weak var topSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bottomSegmentedControl: UISegmentedControl!
    @IBOutlet weak var topCaptionLabel: UILabel!
    @IBOutlet weak var bottomCaptionLabel: UILabel!
    
    @IBAction func topSegmentedControl(_ sender: UISegmentedControl) {
        let choiceIndex = topSegmentedControl.selectedSegmentIndex
        setSegmentContorol(control: topSegmentedControl, choises: topChoices, selectedSegmentIndex: choiceIndex)
    }
    
    @IBAction func bottomSegmentedControl(_ sender: UISegmentedControl) {
        let choiceIndex = bottomSegmentedControl.selectedSegmentIndex
        setSegmentContorol(control: bottomSegmentedControl, choises: bottomChoices, selectedSegmentIndex: choiceIndex)
    }
    
    func setSegmentContorol(control: UISegmentedControl, choises: [CaptionOption], selectedSegmentIndex: Int) {
        // セグメントコントロールの初期化
        control.removeAllSegments()
        
        // セグメントコントロールへ選択内容を追加
        for choice in choises {
            control.insertSegment(withTitle: choice.emoji, at: choises.count, animated: false)
        }
        
        // 初期化した際、インデックスも消えたため、インデックスを再設定
        control.selectedSegmentIndex = selectedSegmentIndex
        
        // ラベルの切り替え
        let selectedCaption = choises[control.selectedSegmentIndex]
        control.selectedSegmentTintColor = .blue
        if control == topSegmentedControl {
            topCaptionLabel.text = selectedCaption.captionText
        } else {
            bottomCaptionLabel.text = selectedCaption.captionText
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentContorol(control: topSegmentedControl, choises: topChoices, selectedSegmentIndex: 0)
        setSegmentContorol(control: bottomSegmentedControl, choises: bottomChoices, selectedSegmentIndex: 0)
    }

    @IBAction func dragTopLabel(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            topCaptionLabel.center = sender.location(in: view)
        }
    }
    
    @IBAction func dragBottomLabel(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            bottomCaptionLabel.center = sender.location(in: view)
        }
    }
}

