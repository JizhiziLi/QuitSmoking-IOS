//
//  UserAccountViewController.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/22.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit
import HealthKit

class UserAccountViewController: UIViewController,UITextFieldDelegate {
    var layout = Layout()
    var color = Color()
    var registerViewLayout = RegisterViewLayout()
    var UserNameTextField: UITextField!
    var PasswordTextField: UITextField!
    var UsernameLabel:UILabel!
    var PasswordLabel:UILabel!
    var HealthKitLabel:UILabel!
    var confirmBtn:UIButton!
    var UsernameIconImageView:UIImageView!
    var PasswordIconImageView:UIImageView!
    var HealthkitIconImageView:UIImageView!
    var HealthkitAuthenticationBtm:UIButton!
    
    var userSignUp = UserSignUp()
    
    
    //Healthkit var
    var Age: Int = 0
    var Gender: String = ""
    var Weight: HKQuantitySample?
    //var weight: String = ""
    var Height: HKQuantitySample?
    //var height: String = ""
    var BloodType: NSString = ""
    var UserName:NSString?
    var Password:NSString?
    
    var bottomView:UIView!
    var registerTopView:RegisterTopView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //topView

        registerTopView = RegisterTopView()
        registerTopView.frame = CGRectMake(0, 0,view.bounds.width,view.bounds.height/4)
        registerTopView.backgroundColor = color.ViewBackgroundColor
        registerTopView.CircleMarginLeft = 50.0
        registerTopView.CirclePaddingLeft = (view.bounds.width-100)*0.45
        registerTopView.CircleStrokeColor = color.TextFieldBackgroundColor
        registerTopView.CircleOneFillinColor = color.LightBlueColor
        registerTopView.CircleTwoFillinColor = color.TextFieldBackgroundColor
        registerTopView.CircleThreeFillinColor = color.TextFieldBackgroundColor
        registerTopView.CircleMarginTop = view.bounds.height*0.1
        registerTopView.CirclePathWidth = 13.0
        registerTopView.CircleR = (view.bounds.width-100)/10
        registerTopView.LinePathWidth = 5.0
        registerTopView.LineStartMarginLeft = 50.0
        registerTopView.LineEndMarginLeft = view.bounds.width-50.0
        registerTopView.LineMarginTop = registerTopView.CircleR/2+registerTopView.CircleMarginTop
        registerTopView.LineStrokeColor = color.TextFieldBackgroundColor
        
        //bottomView
        
        bottomView = UIView()
        bottomView.frame = CGRectMake(0,view.bounds.height/4, view.bounds.width, 3*(view.bounds.height/4))
        bottomView.backgroundColor = color.LightGrayColor
        
        //TextField
        UserNameTextField = UITextField()
        PasswordTextField = UITextField()
        UserNameTextField.backgroundColor = color.TextFieldGrayColor
        PasswordTextField.backgroundColor = color.TextFieldGrayColor
        PasswordTextField.secureTextEntry = true
        UserNameTextField.delegate = self
        PasswordTextField.delegate = self
        UserNameTextField.textAlignment = .Center
        PasswordTextField.textAlignment = .Center

        //Icon
        UsernameIconImageView = UIImageView ()
        UsernameIconImageView.image = UIImage(named: "UsernameIcon.png")
        
        PasswordIconImageView = UIImageView ()
        PasswordIconImageView.image = UIImage(named: "PasswordIcon.png")
        
        HealthkitIconImageView = UIImageView()
        HealthkitIconImageView.image = UIImage(named: "healthKitIcon.png")
        
        //Label
        UsernameLabel = UILabel()
        UsernameLabel.textColor = color.labelGrayColor
        UsernameLabel.font = UIFont(name:"Helvetica",size:18)
        UsernameLabel.text = "Username"
        UsernameLabel.sizeToFit()
        
        PasswordLabel = UILabel()
        PasswordLabel.textColor = color.labelGrayColor
        PasswordLabel.font = UIFont(name:"Helvetica",size:18)
        PasswordLabel.text = "Password"
        PasswordLabel.sizeToFit()
        
        HealthKitLabel = UILabel()
        HealthKitLabel.textColor = color.labelGrayColor
        HealthKitLabel.font = UIFont(name:"Helvetica",size:18)
        HealthKitLabel.text = "HealthKit"
        HealthKitLabel.sizeToFit()
        
        //Button
        confirmBtn = UIButton()
        confirmBtn.backgroundColor = color.labelGrayColor
        confirmBtn.setTitle("Confirm", forState:UIControlState.Normal)
        confirmBtn.titleLabel!.font = UIFont(name: "Helvetica", size: 14)
        confirmBtn.addTarget(self, action: "ConfirmBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        HealthkitAuthenticationBtm = UIButton()
        HealthkitAuthenticationBtm.backgroundColor = color.LightBlueColor
        HealthkitAuthenticationBtm.setTitle("Authentication",forState:UIControlState.Normal)
        HealthkitAuthenticationBtm.titleLabel!.font = UIFont(name: "Helvetica", size: 18)
        HealthkitAuthenticationBtm.addTarget(self, action: "HealthKitAuthentication", forControlEvents: UIControlEvents.TouchUpInside)
        
        // View
        view.addSubview(registerTopView)
        view.addSubview(bottomView)
        bottomView.addSubview(UserNameTextField)
        bottomView.addSubview(PasswordTextField)
        bottomView.addSubview(confirmBtn)
        bottomView.addSubview(UsernameIconImageView)
        bottomView.addSubview(PasswordIconImageView)
        bottomView.addSubview(UsernameLabel)
        bottomView.addSubview(PasswordLabel)
        bottomView.addSubview(HealthKitLabel)
        bottomView.addSubview(HealthkitAuthenticationBtm)
        bottomView.addSubview(HealthkitIconImageView)
        
        //Auto Layout
        AutoLayoutConstraint()
    }

    // AutoLayoutConstraint()
    func AutoLayoutConstraint(){
        //UserNameIcon
        UsernameIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var UsernameIconImageViewConstraintWidth = NSLayoutConstraint(item: self.UsernameIconImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:0, constant:registerViewLayout.iconWidth)
        var UsernameIconImageViewConstraintHeight = NSLayoutConstraint(item: self.UsernameIconImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:registerViewLayout.iconWidth)
        var UsernameIconImageViewConstraintX = NSLayoutConstraint(item: self.UsernameIconImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var UsernameIconImageViewConstraintY = NSLayoutConstraint(item: self.UsernameIconImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Top, multiplier:1, constant:registerViewLayout.textFieldTitleMarginTop)
        //UserNameLabel
        UsernameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var UsernameLabelConstraintX = NSLayoutConstraint(item: self.UsernameLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.UsernameIconImageView, attribute: NSLayoutAttribute.Right, multiplier:1, constant:registerViewLayout.labelNameMarginLeft)
        var UsernameLabelConstraintY = NSLayoutConstraint(item: self.UsernameLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.UsernameIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        //UserNameTextField
        UserNameTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var UserNameConstraintWidth = NSLayoutConstraint(item: self.UserNameTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var UserNameConstraintHeight = NSLayoutConstraint(item: self.UserNameTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var UserNameConstraintX = NSLayoutConstraint(item: self.UserNameTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var UserNameConstraintY = NSLayoutConstraint(item: self.UserNameTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.UsernameIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:registerViewLayout.textFieldMarginTop)
        
        //PasswordIcon
        PasswordIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var PasswordIconImageViewConstraintWidth = NSLayoutConstraint(item: self.PasswordIconImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:0, constant:registerViewLayout.iconWidth)
        var PasswordIconImageViewConstraintHeight = NSLayoutConstraint(item: self.PasswordIconImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:registerViewLayout.iconWidth)
        var PasswordIconImageViewConstraintX = NSLayoutConstraint(item: self.PasswordIconImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var PasswordIconImageViewConstraintY = NSLayoutConstraint(item: self.PasswordIconImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.UserNameTextField, attribute: NSLayoutAttribute.Top, multiplier:1, constant:registerViewLayout.textFieldPadding)
        //PasswordLabel
        PasswordLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var PasswordLabelConstraintX = NSLayoutConstraint(item: self.PasswordLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.PasswordIconImageView, attribute: NSLayoutAttribute.Right, multiplier:1, constant:registerViewLayout.labelNameMarginLeft)
        var PasswordLabelConstraintY = NSLayoutConstraint(item: self.PasswordLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.PasswordIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        //PasswordTextField
        PasswordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var PasswordTextFieldConstraintWidth = NSLayoutConstraint(item: self.PasswordTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var PasswordTextFieldConstraintHeight = NSLayoutConstraint(item: self.PasswordTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var PasswordTextFieldConstraintX = NSLayoutConstraint(item: self.PasswordTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var PasswordTextFieldConstraintY = NSLayoutConstraint(item: self.PasswordTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.PasswordIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:registerViewLayout.textFieldMarginTop)
        
        //HealthKitLabelImageView
        HealthkitIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var HealthkitIconImageViewConstraintWidth = NSLayoutConstraint(item: self.HealthkitIconImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:0, constant:registerViewLayout.iconWidth)
        var HealthkitIconImageViewConstraintHeight = NSLayoutConstraint(item: self.HealthkitIconImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:registerViewLayout.iconWidth)
        var HealthkitIconImageViewConstraintX = NSLayoutConstraint(item: self.HealthkitIconImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var HealthkitIconImageViewConstraintY = NSLayoutConstraint(item: self.HealthkitIconImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.PasswordTextField, attribute: NSLayoutAttribute.Top, multiplier:1, constant:registerViewLayout.textFieldPadding)
        
        //HealthKitLabel
        HealthKitLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var HealthKitLabelConstraintX = NSLayoutConstraint(item: self.HealthKitLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.HealthkitIconImageView, attribute: NSLayoutAttribute.Right, multiplier:1, constant:registerViewLayout.labelNameMarginLeft)
        var HealthKitLabelConstraintY = NSLayoutConstraint(item: self.HealthKitLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.HealthkitIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        //HealthkitButton
        HealthkitAuthenticationBtm.setTranslatesAutoresizingMaskIntoConstraints(false)
        var HealthkitAuthenticationBtmConstraintWidth = NSLayoutConstraint(item: self.HealthkitAuthenticationBtm, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var HealthkitAuthenticationBtmConstraintHeight = NSLayoutConstraint(item: self.HealthkitAuthenticationBtm, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var HealthkitAuthenticationBtmConstraintX = NSLayoutConstraint(item: self.HealthkitAuthenticationBtm, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var HealthkitAuthenticationBtmConstraintY = NSLayoutConstraint(item: self.HealthkitAuthenticationBtm, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.HealthkitIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:registerViewLayout.textFieldMarginTop)
        // ConfirmBtn
        
        confirmBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var confirmBtnConstraintWidth = NSLayoutConstraint(item: self.confirmBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:0.3, constant:0)
        var confirmBtnConstraintHeight = NSLayoutConstraint(item: self.confirmBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.LongButtonHeight)
        var confirmBtnConstraintX = NSLayoutConstraint(item: self.confirmBtn, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.HealthkitAuthenticationBtm, attribute: NSLayoutAttribute.Right, multiplier:1, constant:0)
        var confirmBtnConstraintY = NSLayoutConstraint(item: self.confirmBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Bottom, multiplier:0.85, constant:0)
        
        view.addConstraint(UserNameConstraintHeight)
        view.addConstraint(UserNameConstraintWidth)
        view.addConstraint(UserNameConstraintX)
        view.addConstraint(UserNameConstraintY)
        view.addConstraint(UsernameIconImageViewConstraintHeight)
        view.addConstraint(UsernameIconImageViewConstraintWidth)
        view.addConstraint(UsernameIconImageViewConstraintX)
        view.addConstraint(UsernameIconImageViewConstraintY)
        view.addConstraint(UsernameLabelConstraintX)
        view.addConstraint(UsernameLabelConstraintY)
        view.addConstraint(PasswordIconImageViewConstraintHeight)
        view.addConstraint(PasswordIconImageViewConstraintWidth)
        view.addConstraint(PasswordIconImageViewConstraintX)
        view.addConstraint(PasswordIconImageViewConstraintY)
        view.addConstraint(PasswordLabelConstraintX)
        view.addConstraint(PasswordLabelConstraintY)
        view.addConstraint(PasswordTextFieldConstraintWidth)
        view.addConstraint(PasswordTextFieldConstraintHeight)
        view.addConstraint(PasswordTextFieldConstraintX)
        view.addConstraint(PasswordTextFieldConstraintY)
        view.addConstraint(HealthkitIconImageViewConstraintHeight)
        view.addConstraint(HealthkitIconImageViewConstraintWidth)
        view.addConstraint(HealthkitIconImageViewConstraintX)
        view.addConstraint(HealthkitIconImageViewConstraintY)
        view.addConstraint(HealthKitLabelConstraintX)
        view.addConstraint(HealthKitLabelConstraintY)
        view.addConstraint(HealthkitAuthenticationBtmConstraintHeight)
        view.addConstraint(HealthkitAuthenticationBtmConstraintWidth)
        view.addConstraint(HealthkitAuthenticationBtmConstraintX)
        view.addConstraint(HealthkitAuthenticationBtmConstraintY)
        view.addConstraint(confirmBtnConstraintHeight)
        view.addConstraint(confirmBtnConstraintWidth)
        view.addConstraint(confirmBtnConstraintX)
        view.addConstraint(confirmBtnConstraintY)
    }
    
    func HealthKitAuthentication() {
        userSignUp.Authorize()
    }
    func ConfirmBtn(sender: UIButton) {
        UserName = self.UserNameTextField.text
        Password = self.PasswordTextField.text
        Age = userSignUp.healthKitMaster.readProfile().age!
        Gender = userSignUp.healthKitMaster.convertHKSexToString(userSignUp.healthKitMaster.readProfile().biologicalsex?.biologicalSex)
        BloodType = userSignUp.healthKitMaster.convertHKBloodTypeToString(userSignUp.healthKitMaster.readProfile().bloodtype?.bloodType)
        
        userSignUp.updateHeight()
        userSignUp.updateWeight()
        userSignUp.updateHeartRate()
        userSignUp.updateBloodPressureDiastolic()
        userSignUp.updateBloodPressureSystolic()
        
        println(Age)
        println(Gender)
        println(BloodType)
        
        println("try the calculate class")
        
        userSignUp.accessHeartRateAverageInFiveWeeks()
        userSignUp.accessHeartRateAverageInOneWeek()
        userSignUp.accessBloodPressureDiastolicAverageInFiveWeeks()
        userSignUp.accessBloodPressureDiastolicAverageInOneWeek()
        userSignUp.accessBloodPressureSystolicAverageInFiveWeeks()
        userSignUp.accessBloodPressureSystolicAverageInOneWeek()

        performSegueWithIdentifier("AccountToHealthkit", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    // check the user name if is exist
    func checkIfUserNameIsAvailable(UserName:NSString)->Bool{
        var check = false
        println("check the name")
        return check
    }
    func UpdateUserNameAndPassword(userName:NSString,password:NSString){
        if(userName != "" && password != ""){
            println("Update")
        }else{
            //notification is empty
        }
    }
}
