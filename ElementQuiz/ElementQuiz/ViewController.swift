//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Apple on 2024/10/15.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    
    enum Mode {
        case flashCard
        case quiz
    }
    
    enum State {
        case question
        case answer
        case score
    }
    
    var state: State = .question
    var mode: Mode = .flashCard {
        // セッターが実行される度に処理が走る
        didSet {
            switch mode {
            case .flashCard:
                setupFlashCards()
            case .quiz:
                setupQuiz()
            }
            
            
            updateUI()
        }
    }
    
    // クイズ用変数
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画像更新
        let elementName = elementList[0]
        imageView.image = UIImage(named: elementName)
        updateFlashCardUI(elementName: elementName)
    }
    
    @IBAction func showAnswer() {
        showAnswerButton.isHidden = false
        
        state = .answer
        answerLabel.text = elementList[currentElementIndex]
        
        // 画像更新
        let elementName = elementList[currentElementIndex]
        imageView.image = UIImage(named: elementName)
        updateFlashCardUI(elementName: elementName)
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
            if mode == .quiz {
                state = .score
                updateUI()
                return
            }
        }
        
        state = .question
        
        // 画像更新
        let elementName = elementList[currentElementIndex]
        imageView.image = UIImage(named: elementName)
        
        switch mode {
        case .flashCard:
            updateFlashCardUI(elementName: elementName)
        case .quiz:
            updateQuizUI(elementName: elementName)
        }
    }
    
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    
    func updateFlashCardUI(elementName: String) {
        modeSelector.selectedSegmentIndex = 0
        textField.isHidden = true
        textField.resignFirstResponder()
        
        showAnswerButton.isHidden = false
        nextButton.isEnabled = true
        nextButton.setTitle("next Element", for: .normal)
        
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "?"
        }
    }
    
    func updateQuizUI(elementName: String) {
        modeSelector.selectedSegmentIndex = 1
        textField.isHidden = false
        showAnswerButton.isHidden = true
        
        if currentElementIndex == elementList.count - 1 {
            nextButton.setTitle("Show Score", for: .normal)
        } else {
            nextButton.setTitle("Next Quiz", for: .normal)
        }
        
        switch state {
        case .question:
            textField.isEnabled = true
            textField.text = ""
            textField.becomeFirstResponder()
        case .answer:
            textField.isEnabled = false
            textField.resignFirstResponder()
        case .score:
            textField.isHidden = true
            textField.resignFirstResponder()
        }
        
        switch state {
        case .question:
            answerLabel.text = ""
        case .answer:
            if answerIsCorrect {
                answerLabel.text = "⭕️"
            } else {
                answerLabel.text = "❌"
            }
        case .score:
            answerLabel.text = ""
            print("ここにスコアを出力")
        }
        
        if state == .score {
            displayScoreAlert()
        }
    }
    
    func updateUI() {
        // 画像更新
        let elementName = elementList[currentElementIndex]
        imageView.image = UIImage(named: elementName)
        
        switch mode {
        case .flashCard:
            updateFlashCardUI(elementName: elementName)
        case .quiz:
            updateQuizUI(elementName: elementName)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldContents = textField.text!
        
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
        }
        
        state = .answer
        updateUI()
        
        return true
    }
    
    func displayScoreAlert() {
        let alert = UIAlertController(title: "Quiz Score", message: "Your Score: \(correctAnswerCount) / \(elementList.count)", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: scoreAlertDismissed(_:))
        
        alert.addAction(dismissAction)
        
        // UIViewControllerのメソッド
        present(alert, animated: true, completion: nil)
    }
    
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }
    
    func setupFlashCards() {
        state = .question
        currentElementIndex = 0
    }
    
    func setupQuiz() {
        state = .question
        currentElementIndex = 0
        answerIsCorrect = false
        correctAnswerCount = 0
    }
}

