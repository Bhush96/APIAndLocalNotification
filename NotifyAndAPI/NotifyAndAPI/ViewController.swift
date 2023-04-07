//
//  ViewController.swift
//  NotifyAndAPI
//
//  Created by Bhushan Tambe on 06/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var localNf: UIButton!
    @IBOutlet weak var apiCall: UIButton!
    @IBOutlet weak var apiCallAf: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        modifyButtons()
    }

    func modifyButtons(){
        localNf.layer.cornerRadius = 10
        apiCall.layer.cornerRadius = 10
        apiCallAf.layer.cornerRadius = 10
    }
}


