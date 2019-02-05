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
    func operand(num1: Double, num2: Double) -> Double {
        switch self {
        case .plus:
            return num1 + num2
        
        case .minus:
            return num1 - num2
            
        case .multiple:
            return num1 * num2
        default:
            return 0
        }
    }
}

protocol ViewModelInputs {
    func enterNumber(number: String)
    func enterOperand(operandStr: String)
}

protocol ViewModelOutputs {
    var didTextNumber: ((String) -> Void)? { get set }
    var didCalculateNumber: ((String) -> Void)? { get set }
}

class ViewModel: ViewModelBinding, ViewModelInputs, ViewModelOutputs {
    
    var inputs: ViewModelInputs { return self }
    var outputs: ViewModelOutputs { return self }

    // MARK: - ViewMoedl Inputs Parameters
    var inputNumberString: String!
    
    // MARK: - ViewMoedl Outputs Parameters
    var didTextNumber: ((String) -> Void)?
    var didCalculateNumber: ((String) -> Void)?
    
    // MARK: - Variable
    private var tmpNumber: Double?
    private var operand: Operand?
    
    init(totalNumberString: String) {
        self.inputNumberString = totalNumberString
    }
    
    // MARK: - ViewMoedl Inputs
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
        operand = getOperandCharater(char: operandStr)
        
        guard let secondNumber = Double(inputNumberString) else { return }
        calculator(num1: tmpNumber, num2: secondNumber, operand: operand)
    }
    
    func calculator(num1: Double?, num2: Double, operand: Operand?) {
        guard let num1 = num1 else { return }
        guard let operand = operand else { return }
        
        let result = operand.operand(num1: num1, num2: num2)
        
        // 確定小數點後面有沒有值，沒有就回傳整數，有回傳 Double
        let numberString: String = result == floor(result) ? String(Int(result)) : String(result)
        didCalculateNumber?(numberString)

        // Change total number, reset temp Number and operand
        tmpNumber = nil
    }
}

private extension ViewModel {
    
    func isFirstCharZero(number: String) {
        if inputNumberString != "0" {
            inputNumberString += number
        } else {
            inputNumberString = number
        }
    }
    
    func charIsOnLimited(numberStr: String) -> Bool {
        guard numberStr.count < 9 else { return false }
        return true
    }
    
    func getOperandCharater(char: String) -> Operand {
        return Operand(rawValue: char)!
    }
    
    func swapTotalAndTmpValue() {
        guard let value = Double(inputNumberString) else { return }
        
        tmpNumber = value
        inputNumberString = "0"
    }
}
