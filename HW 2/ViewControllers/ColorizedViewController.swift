//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class ColorizedViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    var delegate: BackgroundViewController!
    private let minValue = 0.00
    private let maxValue = 1.00
    lazy var valuesRange = minValue...maxValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        colorView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        setColor()
        setValueLabel(for: redLabel, greenLabel, blueLabel)
        
    }
    
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate?.view.backgroundColor = colorView.backgroundColor
        dismiss(animated: true)
    }
    
    
    @IBAction func rgbText(_ sender: UITextField) {
        setColor()
                
        switch sender {
        case redTextField: setValueLabel(for: redLabel)
        case greenTextField: setValueLabel(for: greenLabel)
        default: setValueLabel(for: blueLabel)
        }
        
    }
    
    // Изменение цветов слайдерами
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
                
        switch sender {
        case redSlider: setValueLabel(for: redLabel)
        case greenSlider: setValueLabel(for: greenLabel)
        default: setValueLabel(for: blueLabel)
        }
    }

    // Значения RGB
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}


// MARK: Private method
extension ColorizedViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
    }
    
    internal func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool  {
    // кол-во симовлоов
        guard let textFieldText = textField.text,
        let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
    // максимальное значение
        let newText =
            NSString(string: textField.text!)
            .replacingCharacters(in: range, with: string)
        if newText.isEmpty {
          return true
        }
        
        return count <= 4 && valuesRange.contains(Double(newText) ?? minValue - 1.00)
      }
    
    
    
    
    
// Цвет вью
 private func setColor() {
    colorView.backgroundColor = UIColor(
        red: CGFloat(redSlider.value),
        green: CGFloat(greenSlider.value),
        blue: CGFloat(blueSlider.value),
        alpha: 1
    )
//    colorView.backgroundColor = UIColor(
//        red: CGFloat(Float(redTextField.hashValue)),
//        green: CGFloat(greenTextField.hashValue),
//        blue: CGFloat(blueTextField.hashValue),
//        alpha: 1
//    )
}

    private func setValueLabel(for labels: UILabel...) {
    labels.forEach { label in
        switch label  {
        case redLabel:
            label.text = string(from: redSlider)
        case greenLabel:
            label.text = string(from: greenSlider)
        default:
            label.text = string(from: blueSlider)
        }
    }
}
    private func setValueText(for texts: UITextField...){
        texts.forEach { text in
            switch text  {
            case redTextField:
                text.text = string(from: redSlider)
            case greenTextField:
                text.text = string(from: greenSlider)
            default:
                text.text = string(from: blueSlider)
            }
        }
        
    }
}
