//
//  CalculateMachineTests.swift
//  CalculateMachineTests
//
//  Created by George Liu on 2019/2/3.
//  Copyright © 2019 George Liu. All rights reserved.
//

import XCTest
@testable import CalculateMachine

class CalculateMachineTests: XCTestCase {

    var viewModel: ViewModel!
    
    override func setUp() {
    }

    override func tearDown() {
        viewModel = nil
    }

    //MARK: - Total Number is zero
    func test_InputIs0_Return0() {
        viewModel = ViewModel(totalNumberString: "0")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "0")
        }
        
        let inputNumberStr = "0"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    
    func test_InputIs8_Return8() {
        viewModel = ViewModel(totalNumberString: "0")

        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "8")
        }
        
        let inputNumberStr = "8"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    
    //MARK: - Total Number is not zero
    func test_TotalNumberIs1AndInputIs7_Return17() {
        viewModel = ViewModel(totalNumberString: "1")

        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "17")
        }
        
        let inputNumberStr = "7"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    
    func test_TotalNumberIs97AndInputIs2_Return972() {
        viewModel = ViewModel(totalNumberString: "97")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "972")
        }
        
        let inputNumberStr = "2"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }

    //MARK: - Total Number charaters over 9 charaters
    func test_TotalNumberIs978276125AndInputIs2_Return978276125() {
        viewModel = ViewModel(totalNumberString: "978276125")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "978276125")
        }
        
        let inputNumberStr = "2"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    
    // MARK: - Tap Operand Operation
    private func operandStatment(num: String, operand: String) {
        viewModel.inputs.enterOperand(operandStr: operand)
        viewModel.inputs.enterNumber(number: num)
    }
    
    // MARK: - PLUS
    func test_1Plus97_Return98() {
        viewModel = ViewModel(totalNumberString: "1")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "98")
        }
        
        operandStatment(num: "97", operand: "+")
        viewModel.inputs.enterOperand(operandStr: "+")
    }
    
    func test_798271382Plus467282_Return798738664() {
        viewModel = ViewModel(totalNumberString: "798271382")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "798738664")
        }
        
        operandStatment(num: "467282", operand: "+")
        viewModel.inputs.enterOperand(operandStr: "+")
    }
    
    // MARK: - Minus
    func test_97Minus1_Return96() {
        viewModel = ViewModel(totalNumberString: "97")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "96")
        }
        
        operandStatment(num: "1", operand: "-")
        viewModel.inputs.enterOperand(operandStr: "-")
    }
    
    func test_1Minus97_ReturnNegative96() {
        viewModel = ViewModel(totalNumberString: "1")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "-96")
        }
        
        operandStatment(num: "97", operand: "-")
        viewModel.inputs.enterOperand(operandStr: "-")
    }

    func test_798271382Minus467282_Return798738664() {
        viewModel = ViewModel(totalNumberString: "798271382")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "797904100")
        }
        
        operandStatment(num: "467282", operand: "-")
    }
    
    // MARK: - Tap Operand Charater twice
    func test_ChangePlusToMinus91And2_Return89() {
        viewModel = ViewModel(totalNumberString: "91")
        
        var outputs = viewModel.outputs
//        outputs.resultDouble = {
//            XCTAssertEqual($0, 89)
//        }
        
        var inputOperandStr = "+"
        viewModel.inputs.enterOperand(operandStr: inputOperandStr)
        inputOperandStr = "-"
        viewModel.inputs.enterOperand(operandStr: inputOperandStr)

        let inputNumberStr = "2"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    

}
