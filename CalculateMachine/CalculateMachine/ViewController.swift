//
//  ViewController.swift
//  CalculateMachine
//
//  Created by George Liu on 2019/2/3.
//  Copyright © 2019 George Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var llNumber: UILabel!

    @IBAction func didTapNumberBtn(_ sender: UIButton) {
        guard let numberString = sender.titleLabel?.text else { return }
        viewModel.inputs.enterNumber(number: numberString)
    }
    
    @IBAction func didTapOperand(_ sender: UIButton) {
        guard let numberString = sender.titleLabel?.text else { return }
        viewModel.inputs.enterOperand(operandStr: numberString)
    }
    
    @IBAction func didTapEqual(_ sender: UIButton) {
        viewModel.inputs.equal()
    }
    
    @IBAction func didTapAC(_ sender: UIButton) {
        viewModel.inputs.reset()
    }
    
    @IBAction func didTapNegitive(_ sender: UIButton) {
        viewModel.inputs.negitive()
    }
    
    @IBAction func didTapPercentage(_ sender: UIButton) {
        viewModel.inputs.percent()
    }
    
    private let viewModel = ViewModel(inputNumberString: "0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        bindViewModel()
    }
    
    private func bindViewModel() {
        var outputs = viewModel.outputs
        
        outputs.didTextNumber = { [weak self] (result) in
            self?.llNumber.text = String(result)
            self?.viewModel.inputNumber(number: result)
        }
        
        outputs.didCalculateNumber = { [weak self] (result) in
            self?.llNumber.text = String(result)
            self?.viewModel.inputNumber(number: result)
        }
    }
    
}

