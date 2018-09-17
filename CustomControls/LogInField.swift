//
//  LogInField.swift
//  CustomControls
//
//  Created by Jordan Morgan on 5/28/16.
//  Copyright © 2016 Dreaming In Binary. All rights reserved.
//

import UIKit

enum FieldType
{
    case Email
    case Password
}


@IBDesignable
class LogInField: UIView, UITextFieldDelegate
{
    //MARK: Properties
    var type:FieldType = .Email
    @IBInspectable var useForEmail: Bool = true
    private let topLbl:UILabel = UILabel()
    private let inputTxtField:UITextField = UITextField()
    private let bottomLineView:UIView = UIView()
    
    //MARK: Initializers
    init(frame: CGRect, type:FieldType)
    {
        self.type = type
        super.init(frame: frame)
        self.setupControls()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setupControls()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setupControls()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.type = self.useForEmail ? .Email : .Password
        self.setupControls()
    }
    
    override open var intrinsicContentSize: CGSize {
       return CGSize(width: 200, height: 40)
    }
    
    //MARK invalid input animations
    private func animateInvalidEmailInput() {
        self.topLbl.textColor = UIColor.red
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.topLbl.textColor = UIColor.lightGray
        }
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.topLbl.centerX - 8, y: self.topLbl.centerY))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.topLbl.centerX + 8, y: self.topLbl.centerY))
        animation.repeatCount = 5
        animation.autoreverses = true
        self.topLbl.layer.add(animation, forKey: "position")
        
        CATransaction.commit()
    }
    
    
    func executeClosureIfEmailIsValid(onValidCompletion: ()-> ()) {
        guard let text = self.inputTxtField.text, text.count > 0 else {
            return
        }
        do{
            let emailRegex = try NSRegularExpression(pattern: "^[A_Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive)
            
            if emailRegex.firstMatch(in: text, options: [], range: NSMakeRange(0, text.count)) != nil {
                onValidCompletion()
            }
            else {
                self.animateInvalidEmailInput()
            }
        }
        catch{
            self.animateInvalidEmailInput()
        }
    }
    
    //MARK: UI Methods
    private func setupControls()
    {
        self.addSubview(self.topLbl)
        self.topLbl.frame = CGRect(x:0, y:self.boundsHeight/2, width:self.boundsWidth, height:20)
        self.topLbl.alpha = 0
        self.topLbl.text = self.type == .Email ? "Email" : "Password"
        self.topLbl.textAlignment = .left
        self.topLbl.textColor = UIColor.blue
        self.topLbl.font = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(self.bottomLineView)
        self.bottomLineView.backgroundColor = UIColor.lightGray
        self.bottomLineView.frame = CGRect(x:0, y:self.boundsHeight, width:self.boundsWidth, height:1)
        
        self.addSubview(self.inputTxtField)
        self.inputTxtField.delegate = self
        self.inputTxtField.placeholder = self.type == .Email ? "Email" : "Password"
        self.inputTxtField.isSecureTextEntry = self.type == .Password
        self.inputTxtField.textAlignment = .left
        self.inputTxtField.frame = CGRect(x:0, y:19, width:self.boundsWidth, height:20)
        
        self.inputTxtField.addTarget(self, action: #selector(LogInField.checkTopLabel(_:)), for: .editingChanged)
    }
    
    //MARK: UITextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if (textField.text?.count)! > 0
        {
            self.topLbl.textColor = UIColor.blue
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if (textField.text?.count)! > 0
        {
            self.topLbl.textColor = UIColor.lightGray
        }
        else
        {
            UIView.animate(withDuration: 0.25, animations: {
                self.topLbl.alpha = 0
            }, completion: { done in
                self.topLbl.textColor = UIColor.blue
                self.topLbl.frame = CGRect(x:0, y:self.boundsHeight/2, width:self.boundsWidth, height:1)
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.inputTxtField.endEditing(true)
        return false
    }
    
    @objc func checkTopLabel(_ sender:UITextField!)
    {
        guard (sender.text?.count)! > 0 else
        {
            return
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.topLbl.alpha = 1
            self.topLbl.frame = CGRect(x:0, y:2, width:self.boundsWidth, height:20)
        })
    }
    
    
}
