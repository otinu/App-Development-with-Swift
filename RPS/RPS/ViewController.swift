//
//  ViewController.swift
//  RPS
//
//  Created by Apple on 2024/10/13.
//

import UIKit

class ViewController: UIViewController {
    // ゲーム状態
    enum status {
        case start;
        case win;
        case draw;
        case lose;
    }
    
    // メインラベル
    enum mainLabelList{
        case start
        case win
        case draw
        case lose
        
        var value: String {
            switch self {
            case .start: return "RPS App"
            case .win: return "Win"
            case .draw: return "Draw"
            case .lose: return "Lose"
            }
        }
    }
    
    // サブラベル
    enum subLabelList: String {
        case start
        case rock
        case scissors
        case paper
        
        var value: String {
            switch self {
            case .start: return "ようこそ🤖"
            case .rock: return "✊"
            case .scissors: return "✌️"
            case .paper: return "✋"
            }
        }
    }
    
    // 背景色
    enum backColor {
        case start;
        case win;
        case draw;
        case lose;
        
        var color: UIColor {
            switch self {
            case .start:
                return .white
            case .win:
                return .green
            case .draw:
                return .yellow
            case .lose:
                return .blue
            }
        }
    }
    
    //---------------------------------------------------------------------------
    @IBOutlet weak var TopLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        update(status: .start, sign: 0)
    }
    
    @IBAction func choiceRock(_ sender: UIButton) {
        play(sign: 1)
    }
    
    @IBAction func choiceScissors(_ sender: UIButton) {
        play(sign: 2)
    }
    
    @IBAction func choicePaper(_ sender: UIButton) {
        play(sign: 3)
    }
    
    @IBAction func playAgainChoice(_ sender: UIButton) {
        update(status: .start, sign: 0)
    }
    
    /// - Note: 引数は次の用途で使用します
    /// 0: 使用しない, 1: グー, 2: チョキ, 3: パー
    func play(sign: Int) {
        let cpuSign: Int = Int.random(in: 1...3)
        
        if sign == cpuSign {
            update(status: .draw, sign: cpuSign)
            return
        }
        
        if sign == 1 && cpuSign == 3 || sign == 2 && cpuSign == 1 || sign == 3 && cpuSign == 2 {
            update(status: .lose, sign: cpuSign)
            return
        } else {
            update(status: .win, sign: cpuSign)
            return
        }
    }
    
    func update(status: status, sign: Int) {
        // CPU側のじゃんけん表示
        var subLabelText: String
        switch sign {
        case 1: subLabelText = subLabelList.rock.value
        case 2: subLabelText = subLabelList.scissors.value
        case 3: subLabelText = subLabelList.paper.value
        default:
            subLabelText = "エラー発生"
        }
        
        // 画面表示制御
        rockButton.isEnabled = false
        scissorsButton.isEnabled = false
        paperButton.isEnabled = false
        playAgainButton.isHidden = false
        subLabel.text = subLabelText
        
        switch status {
        case .start:
            TopLabel.text = mainLabelList.start.value
            subLabel.text = subLabelList.start.value
            rockButton.isEnabled = true
            scissorsButton.isEnabled = true
            paperButton.isEnabled = true
            playAgainButton.isHidden = true
            view.backgroundColor = backColor.start.color
        case .win:
            TopLabel.text = mainLabelList.win.value
        case .draw:
            TopLabel.text = mainLabelList.draw.value
        case .lose:
            TopLabel.text = mainLabelList.lose.value
        }
    }
    
}

