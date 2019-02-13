//
//  ViewModel.swift
//  CalculateMachine
//
//  Created by George Liu on 2019/2/3.
//  Copyright © 2019 George Liu. All rights reserved.
//

import Foundation

enum Operand: String {
    
    case plus = "+"
    case minus = "-"
    case multiple = "x"
    case divide = "/"
    
    // 只有等於時 operand 會變成 nil
    func operand(num1: Double, num2: Double) -> Double? {
        switch self {
        case .plus:
            return num1 + num2
        case .minus:
            return num1 - num2
        case .multiple:
            return num1 * num2
        case .divide:
            guard num2 != 0 else { return nil }
            return num1 / num2
        }
    }
}

protocol ViewModelInputs {
    func inputNumber(number: String)
    func enterNumber(number: String)
    func enterOperand(operandStr: String)
    func equal()
    func reset()
    func negitive()
    func percent()
}

protocol ViewModelOutputs {
    var didTextNumber: ((String) -> Void)? { get set }
    var didCalculateNumber: ((String) -> Void)? { get set }
}

class ViewModel: ViewModelBinding, ViewModelInputs, ViewModelOutputs {
    
    var inputs: ViewModelInputs { return self }
    var outputs: ViewModelOutputs { return self }

    // MARK: - ViewMoedl Inputs Parameters
    var inputNumberString: String = "0"
    
    // MARK: - ViewMoedl Outputs Parameters
    var didTextNumber: ((String) -> Void)?
    var didCalculateNumber: ((String) -> Void)?
    
    // MARK: - Variable
    private var tmpNumber: Double?
    private var operand: Operand?
    
    // MARK: - ViewMoedl Inputs
    func inputNumber(number: String) {
        inputNumberString = number
    }
    
    func enterNumber(number: String) {
        if operand != nil {
            swapTotalAndTmpValue()
        }
        
        guard charIsOnLimited(numberStr: inputNumberString) else {
            didTextNumber?(inputNumberString)
            return
        }
        
        isFirstCharZero(number: number)
        didTextNumber?(inputNumberString)
    }
    
    func enterOperand(operandStr: String) {
        guard let secondNumber = Double(inputNumberString) else { return }
        calculate(num1: tmpNumber, num2: secondNumber, operand: operand)
        operand = Operand(rawValue: operandStr)!
    }
    
    func equal() {
        guard let secondNumber = Double(inputNumberString) else { return }
        guard let tmpNumber = tmpNumber else {
            // 若點完運算符號後直接按等於，會使用第一個數字
            calculate(num1: secondNumber, num2: secondNumber, operand: operand)
            return
        }
        
        calculate(num1: tmpNumber, num2: secondNumber, operand: operand)
    }
    
    func reset() {
        inputNumberString = "0"
        tmpNumber = nil
        operand = nil
        didTextNumber?(inputNumberString)
    }

    func negitive() {
        guard var inputNumber = Double(inputNumberString) else { return }
        inputNumber *= -1
        
        didTextNumber?(isIntOrDouble(num: inputNumber))
    }
    
    func percent() {
        guard var inputNumber = Double(inputNumberString) else { return }
        inputNumber *= 0.1
        
        didTextNumber?(isIntOrDouble(num: inputNumber))
    }
}

private extension ViewModel {
    
    // Check input charater
    func isFirstCharZero(number: String) {
        (inputNumberString != "0") ? (inputNumberString += number) : (inputNumberString = number)
    }
    
    func charIsOnLimited(numberStr: String) -> Bool {
        guard numberStr.count < 9 else { return false }
        return true
    }
    
    // After tap operand
    func swapTotalAndTmpValue() {
        guard let value = Double(inputNumberString) else { return }
        
        tmpNumber = value
        inputNumberString = "0"
    }
    
    func calculate(num1: Double?, num2: Double, operand: Operand?) {
        guard let num1 = num1 else { return }
        guard let operand = operand else { return }
        
        // 只有當除數為 0 時回傳 nil
        guard let result = operand.operand(num1: num1, num2: num2) else {
            didCalculateNumber?("錯誤")
            tmpNumber = nil
            return
        }
        
        // 確定小數點後面有沒有值，沒有就回傳整數，有回傳 Double
        let numberString: String = isIntOrDouble(num: result)
        
        didCalculateNumber?(numberString)
        inputNumberString = numberString
        // reset temp Number
        tmpNumber = num2
    }
    
    func isIntOrDouble(num: Double) -> String {
        return num == floor(num) ? String(Int(num)) : String(format: "%.9g", num)
    }
}
