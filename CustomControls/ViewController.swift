//
//  ViewController.swift
//  CustomControls
//
//  Created by Jordan Morgan on 2/28/16.
//  Copyright © 2016 Dreaming In Binary. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var emailLoginField: LogInField!
    
//    var inputEmail:LogInField!
//    var inputPassword:LogInField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.btnLogIn.layer.cornerRadius = 4
        
//        //without autolayout
//        self.inputEmail = LogInField(frame: CGRect(x:self.view.width/2 - 100, y:self.view.centerY - 20, width: 200, height:40), type:.Email)
//        self.view.addSubview(inputEmail)
//
//        self.inputPassword = LogInField(frame: CGRect(x:self.view.width/2 - 100, y:self.view.centerY + 20, width:200, height:40), type: .Password)
//        self.view.addSubview(inputPassword)
        
    }
    
    
    @IBAction func attempLogin(_ sender: Any) {
        self.emailLoginField.executeClosureIfEmailIsValid {
            self.btnLogIn.setTitle("It worked!", for: .normal)
        }
    }
    
    
    
//    override func viewWillLayoutSubviews()
//    {
//        self.inputEmail.frame = CGRect(x:self.view.width/2 - 100, y:self.view.centerY - 20, width:200, height:40)
//        self.inputPassword.frame = CGRect(x:self.view.width/2 - 100, y:self.view.centerY + 20, width:200, height:40)
//    }
    
    
    
    
}

