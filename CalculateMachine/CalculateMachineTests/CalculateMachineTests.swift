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
        viewModel = ViewModel()

    }

    override func tearDown() {
        viewModel = nil
    }

    //MARK: - First Number is zero
    func test_InputIs0_Return0() {
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "0")
        }
        
        let inputNumberStr = "0"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    
    func test_InputIs8_Return8() {

        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            XCTAssertEqual($0, "8")
        }
        
        let inputNumberStr = "8"
        viewModel.inputs.enterNumber(number: inputNumberStr)
    }
    
    //MARK: - First Number is not zero
    func test_TotalNumberIs1AndInputIs7_Return17() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "1")
        viewModel.inputs.enterNumber(number: "7")

        XCTAssertEqual(text, "17")
    }
    
//    func test_TotalNumberIs97AndInputIs2_Return972() {
//        var text: String = ""
//
//        var outputs = viewModel.outputs
//        outputs.didTextNumber = {
//            text = $0
//        }
//
//        viewModel.inputs.enterNumber(number: "97")
//        viewModel.inputs.enterNumber(number: "2")
//        XCTAssertEqual(text, "972")
//    }

    //MARK: - Max1
    func test_TotalNumberIs978276125AndInputIs2_Return978276125() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "978276125")
        viewModel.inputs.enterNumber(number: "2")
        XCTAssertEqual(text, "978276125")
    }
    
    // MARK: - Tap Operand Operation
    private func operandStatment(num: String, operand: String) {
        viewModel.inputs.enterOperand(operandStr: operand)
        viewModel.inputs.enterNumber(number: num)
    }
    
    // MARK: - PLUS
    func test_1Plus97_Return98() {
        var text: String = ""

        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "1")
        operandStatment(num: "97", operand: "+")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "98")
    }
    
//    func test_798271382Plus467282_Return798738664() {
//        var text: String = ""
//
//        var outputs = viewModel.outputs
//        outputs.didCalculateNumber = {
//            text = $0
//        }
//
//        viewModel.inputs.enterNumber(number: "798271382")
//        operandStatment(num: "467282", operand: "+")
//        viewModel.inputs.equal()
//        XCTAssertEqual(text, "798738664")
//    }
    
    // MARK: - Minus
    func test_97Minus1_Return96() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "97")
        operandStatment(num: "1", operand: "-")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "96")
    }
    
    func test_1Minus97_ReturnNegative96() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "1")
        operandStatment(num: "97", operand: "-")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "-96")
    }

//    func test_798271382Minus467282_Return797904100() {
//        var text: String = ""
//
//        var outputs = viewModel.outputs
//        outputs.didCalculateNumber = {
//            text = $0
//        }
//
//        viewModel.inputs.enterNumber(number: "798271382")
//        operandStatment(num: "467282", operand: "-")
//        viewModel.inputs.equal()
//        XCTAssertEqual(text, "797804100")
//    }
    
    // MARK: - Mutiple
    func test_3Mutiple4_Return12() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "3")
        operandStatment(num: "4", operand: "x")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "12")
    }

    func test_5Mutiple0_Return0() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "5")
        operandStatment(num: "0", operand: "x")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "0")
    }
    
    // Divide
    func test_10Divide3_Return3Point33333333() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "10")
        operandStatment(num: "3", operand: "/")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "3.33333333")
    }
    
    func test_8Divide5_Return1Point6() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "8")
        operandStatment(num: "5", operand: "/")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "1.6")
    }

    
    func test_10Divide0_ReturnError() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "10")
        operandStatment(num: "0", operand: "/")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "錯誤")
    }

    // MARK: - Tap Equal with Single Number
    func test_10DivideThenEqual_Return1() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "10")
        viewModel.inputs.enterOperand(operandStr: "/")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "1")
    }
    
    func test_10PlusThenEqual_Return20() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "10")
        viewModel.inputs.enterOperand(operandStr: "+")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "20")
    }

    
    // MARK: - Tap Operand Charater twice
    func test_ChangePlusToMinus91And2_Return89() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "91")
        viewModel.inputs.enterOperand(operandStr: "+")
        operandStatment(num: "2", operand: "-")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "89")
    }
    
    // MARK: - Tap AC
    func test_10PlusResetValue_Return0() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "10")
        viewModel.inputs.enterOperand(operandStr: "+")
        viewModel.inputs.reset()
        XCTAssertEqual(text, "0")
    }
    
    func test_3ResetValueThenAdd10_Return10() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didCalculateNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "3")
        viewModel.inputs.reset()
        operandStatment(num: "10", operand: "+")
        viewModel.inputs.equal()
        XCTAssertEqual(text, "10")
    }
    
    // MARK: - Tap Negitive Charater
    func test_10Point45WithNegitive_ReturnNegitive10Point45() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "10.45")
        viewModel.inputs.negitive()
        XCTAssertEqual(text, "-10.45")
    }

    func test_Negitive10WithNegitive_Return10() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "-10")
        viewModel.inputs.negitive()
        XCTAssertEqual(text, "10")
    }
    
    // MARK: - Tap Precentage Charater
    func test_10WithPrecentage_Return1() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "10")
        viewModel.inputs.percent()
        XCTAssertEqual(text, "1")
    }
    
    func test_0WithPrecentage_Return() {
        var text: String = ""
        
        var outputs = viewModel.outputs
        outputs.didTextNumber = {
            text = $0
        }
        
        viewModel.inputs.enterNumber(number: "0")
        viewModel.inputs.percent()
        XCTAssertEqual(text, "0")
    }

}
