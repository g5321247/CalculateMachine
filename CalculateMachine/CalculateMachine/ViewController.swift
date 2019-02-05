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
        guard let number = sender.titleLabel?.text else {
            return
        }
        
        viewModel.inputs.enterNumber(number: number)
    }
    
    private let viewModel = ViewModel(totalNumberString: "0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        bindViewModel()
    }
    
    private func bindViewModel() {
        var outputs = viewModel.outputs
        
        outputs.didTextNumber = { [weak self] (result) in
            
            self?.llNumber.text = String(result)
        }
        
    }
    
}

