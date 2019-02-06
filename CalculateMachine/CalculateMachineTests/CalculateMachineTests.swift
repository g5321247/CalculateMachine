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
        viewModel = ViewModel(inputNumberString: "0")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "0")
        }
        
        let inputNumberStr = "0"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    
    func test_InputIs8_Return8() {
        viewModel = ViewModel(inputNumberString: "0")

        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "8")
        }
        
        let inputNumberStr = "8"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    
    //MARK: - Total Number is not zero
    func test_TotalNumberIs1AndInputIs7_Return17() {
        viewModel = ViewModel(inputNumberString: "1")

        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "17")
        }
        
        let inputNumberStr = "7"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    
    func test_TotalNumberIs97AndInputIs2_Return972() {
        viewModel = ViewModel(inputNumberString: "97")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "972")
        }
        
        let inputNumberStr = "2"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }

    //MARK: - Total Number charaters over 9 charaters
    func test_TotalNumberIs978276125AndInputIs2_Return978276125() {
        viewModel = ViewModel(inputNumberString: "978276125")
        
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
        viewModel = ViewModel(inputNumberString: "1")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "98")
        }
        
        operandStatment(num: "97", operand: "+")
        viewModel.inputs.equal()
    }
    
    func test_798271382Plus467282_Return798738664() {
        viewModel = ViewModel(inputNumberString: "798271382")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "798738664")
        }
        
        operandStatment(num: "467282", operand: "+")
        viewModel.inputs.equal()
    }
    
    // MARK: - Minus
    func test_97Minus1_Return96() {
        viewModel = ViewModel(inputNumberString: "97")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "96")
        }
        
        operandStatment(num: "1", operand: "-")
        viewModel.inputs.equal()
    }
    
    func test_1Minus97_ReturnNegative96() {
        viewModel = ViewModel(inputNumberString: "1")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "-96")
        }
        
        operandStatment(num: "97", operand: "-")
        viewModel.inputs.equal()
    }

    func test_798271382Minus467282_Return797904100() {
        viewModel = ViewModel(inputNumberString: "798271382")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "797804100")
        }
        
        operandStatment(num: "467282", operand: "-")
        viewModel.inputs.equal()

    }
    
    // MARK: - Mutiple
    func test_3Mutiple4_Return12() {
        viewModel = ViewModel(inputNumberString: "3")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "12")
        }
        
        operandStatment(num: "4", operand: "x")
        viewModel.inputs.equal()
    }

    func test_5Mutiple0_Return0() {
        viewModel = ViewModel(inputNumberString: "5")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "0")
        }
        
        operandStatment(num: "0", operand: "x")
        viewModel.inputs.equal()
    }
    
    // Divide
    func test_10Divide3_Return3Point33333333() {
        viewModel = ViewModel(inputNumberString: "10")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "3.33333333")
        }
        
        operandStatment(num: "3", operand: "/")
        viewModel.inputs.equal()
    }
    
    func test_8Divide5_Return1Point6() {
        viewModel = ViewModel(inputNumberString: "8")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "1.6")
        }
        
        operandStatment(num: "5", operand: "/")
        viewModel.inputs.equal()
    }

    
    func test_10Divide0_ReturnError() {
        viewModel = ViewModel(inputNumberString: "10")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "錯誤")
        }
        
        operandStatment(num: "0", operand: "/")
        viewModel.inputs.equal()
    }

    // MARK: - Tap Equal with Single Number
    func test_10DivideThenEqual_Return1() {
        viewModel = ViewModel(inputNumberString: "10")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "1")
        }
        
        viewModel.inputs.enterOperand(operandStr: "/")
        viewModel.inputs.equal()
    }
    
    func test_10PlusThenEqual_Return1() {
        viewModel = ViewModel(inputNumberString: "10")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "20")
        }
        
        viewModel.inputs.enterOperand(operandStr: "+")
        viewModel.inputs.equal()
    }

    
    // MARK: - Tap Operand Charater twice
    func test_ChangePlusToMinus91And2_Return89() {
        viewModel = ViewModel(inputNumberString: "91")
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "89")
        }
        
        viewModel.inputs.enterOperand(operandStr: "+")
        operandStatment(num: "2", operand: "-")
        viewModel.inputs.equal()
    }
    
    // MARK: - Tap AC
    func test_10PlusResetValue_Return0() {
        viewModel = ViewModel(inputNumberString: "10")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "0")
        }
        
        viewModel.inputs.enterOperand(operandStr: "+")
        viewModel.inputs.reset()
    }
    
    func test_3ResetValueThenAdd10_Return10() {
        viewModel = ViewModel(inputNumberString: "3")
        viewModel.inputs.reset()

        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            XCTAssertEqual($0, "10")
        }
        
        operandStatment(num: "10", operand: "+")
        viewModel.inputs.equal()
    }
    
    // MARK: - Tap Negitive Charater
    func test_10Point45WithNegitive_ReturnNegitive10Point45() {
        viewModel = ViewModel(inputNumberString: "10.45")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "-10.45")
        }
        
        viewModel.inputs.negitive()
    }

    func test_Negitive10WithNegitive_Return10() {
        viewModel = ViewModel(inputNumberString: "-10")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "10")
        }
        
        viewModel.inputs.negitive()
    }
    
    // MARK: - Tap Precentage Charater
    func test_10WithPrecentage_Return1() {
        viewModel = ViewModel(inputNumberString: "10")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "1")
        }
        
        viewModel.inputs.percent()
    }
    
    func test_0WithPrecentage_Return() {
        viewModel = ViewModel(inputNumberString: "0")
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "0")
        }
        
        viewModel.inputs.percent()
    }

}
