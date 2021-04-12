//
//  ColorizedViewController.swift
//  HW 2
//
//  Created by ErrorV9 on 12.06.2018.
//  Copyright © 2021 Vlad Nikitenkov. All rights reserved.
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

    var delegate: ColorizedViewControllerDelegate!
    var viewColor: UIColor!
    
    private let minValue:Float = 0.00
    private let maxValue:Float = 1.00
    lazy var valuesRange = minValue...maxValue

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.backgroundColor = viewColor
        colorView.layer.cornerRadius = 15
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        
        setSliderColor()
        setValueLabel(for: redLabel, greenLabel, blueLabel)
        setValueText(for: redTextField,greenTextField,blueTextField)
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    // Изменение цветов слайдерами
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
// MARK: Private method

extension ColorizedViewController: UITextFieldDelegate {
    
    // Цвет вью
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    private func setSliderColor(){
        let ciColor = CIColor(color: viewColor)
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
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
    private func setValueText(for textsTF: UITextField...) {
        textsTF.forEach { textTF in
            switch textTF  {
            case redTextField:
                textTF.text = string(from: redSlider)
            case greenTextField:
                textTF.text = string(from: greenSlider)
            default:
                textTF.text = string(from: blueSlider)
            }
        }
    }
    // Значения RGB
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    // MARK: text method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    internal func textField(_ textField: UITextField,
                            shouldChangeCharactersIn range: NSRange,
                            replacementString string: String) -> Bool {
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
        return count <= 4 &&
            valuesRange.contains(Float(newText) ?? minValue - 1.00)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        guard let text = textField.text else { return }
        if let currentValue = Float(text)  {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValueLabel(for: redLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValueLabel(for: greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValueLabel(for: blueLabel)
            }
            setColor()
            return
        }
    }
}
