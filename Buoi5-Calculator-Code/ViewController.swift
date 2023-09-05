//
//  ViewController.swift
//  Buoi5-Calculator-Code
//
//  Created by lynnguyen on 20/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView?
    
    private var resutlLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont(name: "Arial", size: 110)
        return label
    }()
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperation: Operation?
    
    enum Operation {
        case add, substract, multiply, divide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        let buttonSize = holder!.frame.size.width / 4
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder!.frame.size.height - buttonSize, width: buttonSize * 3, height: buttonSize))
        zeroButton.backgroundColor = .gray
        zeroButton.setTitle("0", for: .normal)
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.tag = 1
        holder?.addSubview(zeroButton)
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        let decimalButton = UIButton(frame: CGRect(x: buttonSize * 2, y: zeroButton.frame.origin.y, width: buttonSize, height: buttonSize))
        decimalButton.backgroundColor = .gray
        decimalButton.setTitle(",", for: .normal)
        decimalButton.setTitleColor(.white, for: .normal)
        decimalButton.tag = 11
        holder?.addSubview(decimalButton)
        decimalButton.addTarget(self, action: #selector(decimalButtonPressed), for: .touchUpInside)

        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: zeroButton.frame.origin.y - buttonSize, width: buttonSize, height: buttonSize))
            button1.backgroundColor = .gray
            button1.setTitle("\(x + 1)", for: .normal)
            button1.setTitleColor(.white, for: .normal)
            button1.tag = (x + 2)
            holder?.addSubview(button1)
            button1.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)
        }
        
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: zeroButton.frame.origin.y - buttonSize * 2, width: buttonSize, height: buttonSize))
            button2.backgroundColor = .gray
            button2.setTitle("\(x + 4)", for: .normal)
            button2.setTitleColor(.white, for: .normal)
            button2.tag = (x + 5)
            holder?.addSubview(button2)
            button2.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)

        }
        
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: zeroButton.frame.origin.y - buttonSize * 3, width: buttonSize, height: buttonSize))
            button3.backgroundColor = .gray
            button3.setTitle("\(x + 7)", for: .normal)
            button3.setTitleColor(.white, for: .normal)
            button3.tag = x + 8
            holder?.addSubview(button3)
            button3.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)

        }
        
        let operations = ["=", "+", "-", "X", "/"]
        for x in 0..<operations.count {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder!.frame.size.height - buttonSize * CGFloat(x + 1), width: buttonSize, height: buttonSize))
            button4.tag = x + 1
            button4.backgroundColor = .orange
            button4.setTitle(operations[x], for: .normal)
            button4.setTitleColor(.white, for: .normal)
            holder?.addSubview(button4)
            button4.addTarget(self, action: #selector(operationTapped(_ :)), for: .touchUpInside)

        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder!.frame.size.height - buttonSize * 5, width: buttonSize * 3, height: buttonSize))
        clearButton.backgroundColor = .gray
        clearButton.setTitle("Clear All", for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        holder?.addSubview(clearButton)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)

        resutlLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110, width: view!.frame.size.width - 40, height: 100)
        holder?.addSubview(resutlLabel)
    }
    
    @objc func zeroTapped() {
        if let text = resutlLabel.text, resutlLabel.text != "0" {
           resutlLabel.text = "\(text)\(0)"
       }
    }
    
    @objc func decimalButtonPressed(_ sender: UIButton) {

        if let text = resutlLabel.text {
            resutlLabel.text = "\(text),"
        }
        
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resutlLabel.text == "0" {
            resutlLabel.text = "\(tag)"
        } else if let text = resutlLabel.text {
            resutlLabel.text = "\(text)\(tag)"
        }
        
    }
    
    @objc func clearTapped() {
        resutlLabel.text = "0"
        currentOperation = nil
        firstNumber = 0
    }
    
    @objc func operationTapped(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resutlLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resutlLabel.text = "0"
        }
        if tag == 1 {
            if let operation = currentOperation {
                var secondNumber = 0
                if let text = resutlLabel.text, let value = Int(text) {
                    secondNumber = value
                }
                
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resutlLabel.text = String(result)
                    break
                    
                case .substract:
                    let result = firstNumber - secondNumber
                    resutlLabel.text = String(result)
                    break
                    
                case .multiply:
                    let result = firstNumber * secondNumber
                    resutlLabel.text = String(result)
                    break
                    
                case .divide:
                    let result = Double(firstNumber) / Double(secondNumber)
                    resutlLabel.text = String(result)
                    break
                }
            }
        } else if tag == 2 {
            currentOperation = .add
        } else if tag == 3 {
            currentOperation = .substract
        } else if tag == 4 {
            currentOperation = .multiply
        } else if tag == 5 {
            currentOperation = .divide
        }
    }
    
}

