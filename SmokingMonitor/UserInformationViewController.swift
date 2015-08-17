//
//  UserInformationViewController.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/24.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit

class UserInformationViewController:UIViewController,UITextFieldDelegate,UIPickerViewDelegate{
    var color = Color()
    var layout = Layout()
    var registerViewLayout = RegisterViewLayout()
    
    var TargetNumber:Int? = 0
    var confirmBtn:UIButton!
    
    var bottomView:UIView!
    var registerTopView:RegisterTopView!
    
    var SmokeAgeTextField:UITextField!
    var TargetNumberTextField:UITextField!
    
    var smokeAgeLabel:UILabel!
    var targetNumberLabel:UILabel!
    
    var smokeAgeIconImageView:UIImageView!
    var targetNumberIconImageView:UIImageView!
    
    //image View
    
    //Get from Monitor
    var TargetNumberArray = ["0","1","2","3"]
    var SmokeAgeArray = ["less than 1","1","2","3"]
    //Pickers
    
    var TargetNumberPick:UIPickerView! = UIPickerView()
    var SmokeAgePic:UIPickerView! = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //topView
        registerTopView = RegisterTopView()
        registerTopView.frame = CGRectMake(0, 0,view.bounds.width,view.bounds.height/4)
        registerTopView.backgroundColor = color.ViewBackgroundColor
        registerTopView.CircleMarginLeft = 50.0
        registerTopView.CirclePaddingLeft = (view.bounds.width-100)*0.45
        registerTopView.CircleStrokeColor = color.TextFieldBackgroundColor
        registerTopView.CircleOneFillinColor = color.TextFieldBackgroundColor
        registerTopView.CircleTwoFillinColor = color.TextFieldBackgroundColor
        registerTopView.CircleThreeFillinColor = color.LightBlueColor
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
        //ConfirmBtn
        confirmBtn = UIButton()
        confirmBtn.backgroundColor = color.labelGrayColor
        confirmBtn.setTitle("Confirm", forState:UIControlState.Normal)
        confirmBtn.titleLabel!.font = UIFont(name: "Helvetica", size: 14)
        confirmBtn.addTarget(self, action: "ConfirmBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        //Icon
        smokeAgeIconImageView = UIImageView ()
        smokeAgeIconImageView.image = UIImage(named: "UsernameIcon.png")
        
        targetNumberIconImageView = UIImageView ()
        targetNumberIconImageView.image = UIImage(named: "PasswordIcon.png")

        //Label
        smokeAgeLabel = UILabel()
        smokeAgeLabel.textColor = color.labelGrayColor
        smokeAgeLabel.font = UIFont(name:"Helvetica",size:18)
        smokeAgeLabel.text = "Smoking Age"
        smokeAgeLabel.sizeToFit()
        
        targetNumberLabel = UILabel()
        targetNumberLabel.textColor = color.labelGrayColor
        targetNumberLabel.font = UIFont(name:"Helvetica",size:18)
        targetNumberLabel.text = "Smoking Goal"
        targetNumberLabel.sizeToFit()
        //Target number pick

        TargetNumberTextField = UITextField()
        TargetNumberTextField.tag = 0
        TargetNumberTextField.backgroundColor = UIColor.grayColor()
        TargetNumberTextField.delegate = self
        TargetNumberTextField.text = ""
        TargetNumberPick.hidden = true
        TargetNumberPick.delegate = self
        TargetNumberPick.tag = 0
        self.TargetNumberTextField.inputView = TargetNumberPick
        
        //SmokeAge pic
        
        SmokeAgeTextField = UITextField()
        SmokeAgeTextField.tag = 1
        SmokeAgeTextField.backgroundColor = UIColor.grayColor()
        SmokeAgeTextField.delegate = self
        SmokeAgeTextField.text = ""
        SmokeAgePic.hidden = true
        SmokeAgePic.delegate = self
        SmokeAgePic.tag = 1
        self.SmokeAgeTextField.inputView = SmokeAgePic
        
        // View
        
        view.addSubview(registerTopView)
        view.addSubview(bottomView)
        bottomView.addSubview(SmokeAgeTextField)
        bottomView.addSubview(TargetNumberTextField)
        bottomView.addSubview(TargetNumberPick)
        bottomView.addSubview(SmokeAgePic)
        bottomView.addSubview(confirmBtn)
        bottomView.addSubview(targetNumberIconImageView)
        bottomView.addSubview(targetNumberLabel)
        bottomView.addSubview(smokeAgeIconImageView)
        bottomView.addSubview(smokeAgeLabel)
        AutoLayoutConstraint()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func ConfirmBtn(sender: UIButton) {
        //Segue
        performSegueWithIdentifier("InformationToMain", sender: self)
    }
    //pickerView Delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
        if(pickerView.tag == 5){
            return TargetNumberArray.count
        }else{
            return SmokeAgeArray.count
        }
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView.tag == 0){
            return TargetNumberArray[row]
        }else{
            return SmokeAgeArray[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView.tag == 0){
            TargetNumberTextField.text = TargetNumberArray[row]
            TargetNumberPick.hidden = true
        }else{
            SmokeAgeTextField.text = SmokeAgeArray[row]
            SmokeAgePic.hidden = true
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if(textField.tag == 0){
            TargetNumberPick.hidden = false
        }else{
            SmokeAgePic.hidden = false
        }
        return false
    }
    //UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        self.view.endEditing(true);
        return false;
    }
    // AutoLayoutConstraint()
    func AutoLayoutConstraint(){
        //smokeAgeIconImageView
        smokeAgeIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var smokeAgeIconImageViewConstraintWidth = NSLayoutConstraint(item: self.smokeAgeIconImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:0, constant:registerViewLayout.iconWidth)
        var smokeAgeIconImageViewConstraintHeight = NSLayoutConstraint(item: self.smokeAgeIconImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:registerViewLayout.iconWidth)
        var smokeAgeIconImageViewViewConstraintX = NSLayoutConstraint(item: self.smokeAgeIconImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var smokeAgeIconImageViewConstraintY = NSLayoutConstraint(item: self.smokeAgeIconImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Top, multiplier:1, constant:registerViewLayout.textFieldTitleMarginTop)
        
        //smokeAgeLabel
        smokeAgeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var smokeAgeLabelConstraintX = NSLayoutConstraint(item: self.smokeAgeLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.smokeAgeIconImageView, attribute: NSLayoutAttribute.Right, multiplier:1, constant:registerViewLayout.labelNameMarginLeft)
        var smokeAgeLabelConstraintY = NSLayoutConstraint(item: self.smokeAgeLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.smokeAgeIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        //SmokeAgeTextField
        SmokeAgeTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var SmokeAgeTextFieldConstraintWidth = NSLayoutConstraint(item: self.SmokeAgeTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var SmokeAgeTextFieldConstraintHeight = NSLayoutConstraint(item: self.SmokeAgeTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var SmokeAgeTextFieldConstraintX = NSLayoutConstraint(item: self.SmokeAgeTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var SmokeAgeTextFieldConstraintY = NSLayoutConstraint(item: self.SmokeAgeTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.smokeAgeIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:registerViewLayout.textFieldMarginTop)

        //targetNumberIconImageView
        targetNumberIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var targetNumberIconImageViewConstraintWidth = NSLayoutConstraint(item: self.targetNumberIconImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:0, constant:registerViewLayout.iconWidth)
        var targetNumberIconImageViewConstraintHeight = NSLayoutConstraint(item: self.targetNumberIconImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:registerViewLayout.iconWidth)
        var targetNumberIconImageViewConstraintX = NSLayoutConstraint(item: self.targetNumberIconImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var targetNumberIconImageViewConstraintY = NSLayoutConstraint(item: self.targetNumberIconImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.SmokeAgeTextField, attribute: NSLayoutAttribute.Top, multiplier:1, constant:registerViewLayout.textFieldPadding)
        //targetNumberLabel
        targetNumberLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var targetNumberLabelConstraintX = NSLayoutConstraint(item: self.targetNumberLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.targetNumberIconImageView, attribute: NSLayoutAttribute.Right, multiplier:1, constant:registerViewLayout.labelNameMarginLeft)
        var targetNumberLabelConstraintY = NSLayoutConstraint(item: self.targetNumberLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.targetNumberIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        //TargetNumberTextField
        TargetNumberTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var TargetNumberTextFieldConstraintWidth = NSLayoutConstraint(item: self.TargetNumberTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var TargetNumberTextFieldConstraintHeight = NSLayoutConstraint(item: self.TargetNumberTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var TargetNumberTextFieldConstraintX = NSLayoutConstraint(item: self.TargetNumberTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var TargetNumberTextFieldConstraintY = NSLayoutConstraint(item: self.TargetNumberTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.targetNumberIconImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:registerViewLayout.textFieldMarginTop)
        
        confirmBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var confirmBtnConstraintWidth = NSLayoutConstraint(item: self.confirmBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:0.3, constant:0)
        var confirmBtnConstraintHeight = NSLayoutConstraint(item: self.confirmBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.LongButtonHeight)
        var confirmBtnConstraintX = NSLayoutConstraint(item: self.confirmBtn, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.TargetNumberTextField, attribute: NSLayoutAttribute.Right, multiplier:1, constant:0)
        var confirmBtnConstraintY = NSLayoutConstraint(item: self.confirmBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Bottom, multiplier:0.85, constant:0)
       
        
        
        TargetNumberPick.setTranslatesAutoresizingMaskIntoConstraints(false)
        var TargetNumberPickConstraintX = NSLayoutConstraint(item: self.TargetNumberPick, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:0)
        var TargetNumberPickConstraintY = NSLayoutConstraint(item: self.TargetNumberPick, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        
        SmokeAgePic.setTranslatesAutoresizingMaskIntoConstraints(false)
        var SmokeAgePicConstraintX = NSLayoutConstraint(item: self.SmokeAgePic, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:0)
        var SmokeAgePicConstraintY = NSLayoutConstraint(item: self.SmokeAgePic, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)

        view.addConstraint(SmokeAgeTextFieldConstraintHeight)
        view.addConstraint(SmokeAgeTextFieldConstraintWidth)
        view.addConstraint(SmokeAgeTextFieldConstraintX)
        view.addConstraint(SmokeAgeTextFieldConstraintY)
        view.addConstraint(smokeAgeIconImageViewConstraintWidth)
        view.addConstraint(smokeAgeIconImageViewConstraintHeight)
        view.addConstraint(smokeAgeIconImageViewViewConstraintX)
        view.addConstraint(smokeAgeIconImageViewConstraintY)
        view.addConstraint(smokeAgeLabelConstraintX)
        view.addConstraint(smokeAgeLabelConstraintY)
        view.addConstraint(targetNumberIconImageViewConstraintHeight)
        view.addConstraint(targetNumberIconImageViewConstraintWidth)
        view.addConstraint(targetNumberIconImageViewConstraintX)
        view.addConstraint(targetNumberIconImageViewConstraintY)
        view.addConstraint(targetNumberLabelConstraintX)
        view.addConstraint(targetNumberLabelConstraintY)
        view.addConstraint(TargetNumberTextFieldConstraintWidth)
        view.addConstraint(TargetNumberTextFieldConstraintHeight)
        view.addConstraint(TargetNumberTextFieldConstraintX)
        view.addConstraint(TargetNumberTextFieldConstraintY)
        view.addConstraint(confirmBtnConstraintHeight)
        view.addConstraint(confirmBtnConstraintWidth)
        view.addConstraint(confirmBtnConstraintX)
        view.addConstraint(confirmBtnConstraintY)
        view.addConstraint(TargetNumberPickConstraintX)
        view.addConstraint(TargetNumberPickConstraintY)
        view.addConstraint(SmokeAgePicConstraintX)
        view.addConstraint(SmokeAgePicConstraintY)
    }
}
