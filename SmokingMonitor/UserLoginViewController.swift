//
//  ViewController.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/19.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

class UserLoginViewController:UIViewController,UITextFieldDelegate{
    
    var color = Color()
    var layout = Layout()
    var userLoginViewLayout = UserLoginViewLayout()
    // The UI element Declaration
    var UserNameEnterTextField:UITextField!
    var UserPasswordEnterTextField:UITextField!
    var LoginBtn:UIButton!
    var RegisterBtn:UIButton!
    
    var healthKitMaster = HealthKitMaster()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //View
        self.view.backgroundColor = color.ViewBackgroundColor
        //Input TextField
        UserNameEnterTextField = UITextField()
        UserPasswordEnterTextField = UITextField()
        UserPasswordEnterTextField.secureTextEntry = true
        UserNameEnterTextField.backgroundColor = color.TextFieldBackgroundColor
        UserPasswordEnterTextField.backgroundColor = color.TextFieldBackgroundColor
        UserNameEnterTextField.textColor = UIColor.whiteColor()
        UserPasswordEnterTextField.textColor = UIColor.whiteColor()
        UserNameEnterTextField.delegate = self
        UserPasswordEnterTextField.delegate = self
        UserNameEnterTextField.textAlignment = .Center
        UserPasswordEnterTextField.textAlignment = .Center
        //Input TextField Icon
        let UserNameEnterIcon = UIImage(named: "inputUserNameIcon.png")
        let UserPasswordIcon = UIImage(named: "InputPasswordLogo.png")
        let UserNameEnterIconView = UIImageView(image:UserNameEnterIcon)
        let UserPasswordIconView = UIImageView(image:UserPasswordIcon)
        UserNameEnterIconView.backgroundColor = color.TextFieldBackgroundColor
        UserPasswordIconView.backgroundColor = color.TextFieldBackgroundColor
        
        //LoginInBtn
        LoginBtn = UIButton()
        LoginBtn.backgroundColor = color.LightBlueColor
        LoginBtn.setTitle("SIGN IN", forState: UIControlState.Normal)
        LoginBtn.addTarget(self, action:"ConfirmBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //RegisterBtn
        RegisterBtn = UIButton()
        RegisterBtn.backgroundColor = color.ViewBackgroundColor
        RegisterBtn.setTitle("Sign up Smoking Monitor Account", forState:UIControlState.Normal)
        RegisterBtn.titleLabel!.font = UIFont(name:layout.HelveticaTitle, size: layout.titleSize)
        RegisterBtn.addTarget(self, action: "RegisterBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        RegisterBtn.sizeToFit()
        
        //View & subview
        view.addSubview(UserNameEnterTextField)
        view.addSubview(UserPasswordEnterTextField)
        view.addSubview(LoginBtn)
        view.addSubview(RegisterBtn)
        //Auto Layout Constraint
        AutoLayoutConstraint()
    }

    func AutoLayoutConstraint(){
        
        UserNameEnterTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var UserNameEnterTFConstraintWidth = NSLayoutConstraint(item: self.UserNameEnterTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var UserNameEnterTFConstraintHeight = NSLayoutConstraint(item: self.UserNameEnterTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var UserNameEnterTFConstraintX = NSLayoutConstraint(item: self.UserNameEnterTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var UserNameEnterTFConstraintY = NSLayoutConstraint(item: self.UserNameEnterTextField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier:1, constant:0)
        
        UserPasswordEnterTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var UserPasswordEnterTFConstraintWidth = NSLayoutConstraint(item: self.UserPasswordEnterTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.UserNameEnterTextField, attribute: NSLayoutAttribute.Width, multiplier:1, constant:0)
        var UserPasswordEnterTFConstraintHeight = NSLayoutConstraint(item: self.UserPasswordEnterTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var UserPasswordEnterTFConstraintX = NSLayoutConstraint(item: self.UserPasswordEnterTextField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier:1, constant:0)
        var UserPasswordEnterTFConstraintY = NSLayoutConstraint(item: self.UserPasswordEnterTextField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.UserNameEnterTextField, attribute: NSLayoutAttribute.CenterY, multiplier:1.0, constant:userLoginViewLayout.firstTextFieldPaddingBottom)
        
        LoginBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var LoginBtnConstraintWidth = NSLayoutConstraint(item: self.LoginBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.UserNameEnterTextField, attribute: NSLayoutAttribute.Width, multiplier:1, constant:0)
        var LoginBtnConstraintHeight = NSLayoutConstraint(item: self.LoginBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.LongButtonHeight)
        var LoginBtnConstraintX = NSLayoutConstraint(item: self.LoginBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier:1, constant:0)
        var LoginBtnConstraintY = NSLayoutConstraint(item: self.LoginBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.UserPasswordEnterTextField, attribute: NSLayoutAttribute.CenterY, multiplier:1.0, constant:userLoginViewLayout.loginBtnMarginTop)
        
        RegisterBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var RegisterBtnConstraintX = NSLayoutConstraint(item: self.RegisterBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier:1, constant:0)
        var RegisterBtnConstraintY = NSLayoutConstraint(item: self.RegisterBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier:0.9, constant:0)
        

        view.addConstraint(UserNameEnterTFConstraintWidth)
        view.addConstraint(UserNameEnterTFConstraintHeight)
        view.addConstraint(UserNameEnterTFConstraintX)
        view.addConstraint(UserNameEnterTFConstraintY)
        
        view.addConstraint(UserPasswordEnterTFConstraintWidth)
        view.addConstraint(UserPasswordEnterTFConstraintHeight)
        view.addConstraint(UserPasswordEnterTFConstraintX)
        view.addConstraint(UserPasswordEnterTFConstraintY)
        
        view.addConstraint(LoginBtnConstraintWidth)
        view.addConstraint(LoginBtnConstraintHeight)
        view.addConstraint(LoginBtnConstraintX)
        view.addConstraint(LoginBtnConstraintY)
        
        view.addConstraint(RegisterBtnConstraintX)
        view.addConstraint(RegisterBtnConstraintY)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // This func will be called when LoginBtn is clicked
    func ConfirmBtn(sender: UIButton){
        performSegueWithIdentifier("LoginToMain", sender: self)
    }
    // This func will be called when RegisterBtn is clicked
    func RegisterBtn(sender:UIButton){
        performSegueWithIdentifier("LoginToRegister", sender: self)
    }
    //Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        self.UserPasswordEnterTextField.resignFirstResponder()
        self.view.endEditing(true)
        return false

    }
}
