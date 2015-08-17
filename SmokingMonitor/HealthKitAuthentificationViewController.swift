//
//  HealthKitAuthentificationViewController.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/23.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//
import UIKit

class HealthKitAuthentificationViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate{
    
    
    var color = Color()
    var layout = Layout()
    var registerViewLayout = RegisterViewLayout()
    var Age:Int? = 0
    var Gender:String = ""
    var weight:String = ""
    var height: String = ""
    
    //Get from Monitor
    var GenderArray = ["Male","Female"]
    var AgeArray = ["18","19","20"]
    var WeightArray = ["100","101","102"]
    var HeightArray = ["180","181","182","183","184","185","186","187","188"]
    
    
    var HealthKitBtn:UIButton!
    
    var IconMarginLeft:CGFloat = 50.0
    var TextFieldMarginLeft:CGFloat = 50.0
    var IconWidth:CGFloat = 30.0
    var IconMarginTop:CGFloat = 35.0
    var TextFieldMarginTop:CGFloat = 40.0
    var IconPaddingBottom:CGFloat = 85.0
    var confirmBtnWidth = 100.0
    var confirmBtnHeight = 30.0
    
    var AgeTextField:UITextField!
    var GenderTextField:UITextField!
    var WeightTextField:UITextField!
    var HeightTextField:UITextField!
    
    //Image View
    
    var GenderImageView:UIImageView!
    var AgeImageView:UIImageView!
    var HeightImageView:UIImageView!
    var WeightImageView:UIImageView!
    
    //Label
    
    var GenderLabel:UILabel!
    var AgeLabel:UILabel!
    var HeightLabel:UILabel!
    var WeightLabel:UILabel!
    
    // Pick View
    
    var GenderPick: UIPickerView! = UIPickerView()
    var AgePick:UIPickerView! = UIPickerView()
    var WeightPick:UIPickerView! = UIPickerView()
    var HeightPick:UIPickerView! = UIPickerView()
    
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
        registerTopView.CircleOneFillinColor = color.TextFieldBackgroundColor
        registerTopView.CircleTwoFillinColor = color.LightBlueColor
        registerTopView.CircleThreeFillinColor = color.TextFieldBackgroundColor
        registerTopView.CircleMarginTop = view.bounds.height*0.1
        registerTopView.CirclePathWidth = 13.0
        registerTopView.CircleR = (view.bounds.width-100)/10
        registerTopView.LinePathWidth = 5.0
        registerTopView.LineStartMarginLeft = 50.0
        registerTopView.LineEndMarginLeft = view.bounds.width-50.0
        registerTopView.LineMarginTop = registerTopView.CircleR/2+registerTopView.CircleMarginTop
        registerTopView.LineStrokeColor = color.TextFieldBackgroundColor
        
        
        //Confirm Btn
        HealthKitBtn = UIButton()
        HealthKitBtn.addTarget(self, action: "healthKitConfirmBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        HealthKitBtn.titleLabel!.font = UIFont(name: "Helvetica", size: 14)
        HealthKitBtn.backgroundColor = color.labelGrayColor
        HealthKitBtn.setTitle("Confirm",forState:UIControlState.Normal)
        //bottomView
        
        //Gender Pick
        GenderTextField = UITextField()
        GenderTextField.backgroundColor = color.TextFieldGrayColor
        GenderTextField.tag = 0
        GenderTextField.text = "" //if healthkit is null
        GenderTextField.delegate = self
        GenderPick.hidden = true
        GenderPick.delegate = self
        GenderPick.tag = 0
        self.GenderTextField.inputView = GenderPick
        
        GenderLabel = UILabel()
        GenderLabel.textColor = color.labelGrayColor
        GenderLabel.font = UIFont(name:"Helvetica",size:18)
        GenderLabel.text = "Gender"
        GenderLabel.sizeToFit()
        
        AgeLabel = UILabel()
        AgeLabel.textColor = color.labelGrayColor
        AgeLabel.font = UIFont(name:"Helvetica",size:18)
        AgeLabel.text = "Age"
        AgeLabel.sizeToFit()
        
        WeightLabel = UILabel()
        WeightLabel.textColor = color.labelGrayColor
        WeightLabel.font = UIFont(name:"Helvetica",size:18)
        WeightLabel.text = "Weight"
        WeightLabel.sizeToFit()
        
        HeightLabel = UILabel()
        HeightLabel.textColor = color.labelGrayColor
        HeightLabel.font = UIFont(name:"Helvetica",size:18)
        HeightLabel.text = "Height"
        HeightLabel.sizeToFit()

        //ImageView
        
        GenderImageView = UIImageView()
        GenderImageView.image = UIImage(named: "UsernameIcon.png")

        
        AgeImageView = UIImageView()
        AgeImageView.image = UIImage(named: "UsernameIcon.png")

        WeightImageView = UIImageView()
        WeightImageView.image = UIImage(named: "UsernameIcon.png")
    
        HeightImageView = UIImageView()
        HeightImageView.image = UIImage(named: "UsernameIcon.png")
  
        
        //Age pic
        AgeTextField = UITextField()
        AgeTextField.tag = 1
        AgeTextField.backgroundColor = color.TextFieldGrayColor
        AgeTextField.delegate = self
        AgeTextField.text = ""
        AgePick.hidden = true
        AgePick.delegate = self
        AgePick.tag = 1
        self.AgeTextField.inputView = AgePick
        
        //Weight pick
        
        WeightTextField = UITextField()
        WeightTextField.tag = 2
        WeightTextField.backgroundColor = color.TextFieldGrayColor
        WeightTextField.delegate = self
        WeightTextField.text = ""
        WeightPick.hidden = true
        WeightPick.delegate = self
        WeightPick.tag = 2
        self.WeightTextField.inputView = WeightPick
        
        //height pick
        
        HeightTextField = UITextField()
        HeightTextField.tag = 3
        HeightTextField.backgroundColor = color.TextFieldGrayColor
        HeightTextField.delegate = self
        HeightTextField.text = ""
        HeightPick.hidden = true
        HeightPick.delegate = self
        HeightPick.tag = 3
        self.HeightTextField.inputView = HeightPick
        
        //View
        
        bottomView = UIView()
        bottomView.frame = CGRectMake(0,view.bounds.height/4, view.bounds.width, 3*(view.bounds.height/4))
        bottomView.backgroundColor = color.LightGrayColor
        
        bottomView.addSubview(HealthKitBtn)
        view.addSubview(registerTopView)
        view.addSubview(bottomView)
        bottomView.addSubview(GenderTextField)
        bottomView.addSubview(AgeTextField)
        bottomView.addSubview(HeightTextField)
        bottomView.addSubview(WeightTextField)
        bottomView.addSubview(AgePick)
        bottomView.addSubview(WeightPick)
        bottomView.addSubview(HeightPick)
        bottomView.addSubview(GenderPick)
        bottomView.addSubview(GenderImageView)
        bottomView.addSubview(AgeImageView)
        bottomView.addSubview(HeightImageView)
        bottomView.addSubview(WeightImageView)
        bottomView.addSubview(GenderLabel)
        bottomView.addSubview(AgeLabel)
        bottomView.addSubview(HeightLabel)
        bottomView.addSubview(WeightLabel)
        
        AutoLayoutConstraint()
    }
    //PicView Delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
        
        if(pickerView.tag == 0){
            return GenderArray.count
        }else if(pickerView.tag == 1){
            return AgeArray.count
        }else if(pickerView.tag == 2){
            return WeightArray.count
        }else{
            return HeightArray.count
        }
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView.tag==0){
            return GenderArray[row]
        }else if(pickerView.tag == 1){
            return AgeArray[row]
        }else if(pickerView.tag == 2){
            return WeightArray[row]
        }else{
            return HeightArray[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView.tag == 0){
            GenderTextField.text = GenderArray[row]
            GenderPick.hidden = true
        }else if(pickerView.tag == 1){
            AgeTextField.text = AgeArray[row]
            AgePick.hidden = true
        }else if(pickerView.tag == 2){
            WeightTextField.text = WeightArray[row]
            WeightPick.hidden = true
        }else{
            HeightTextField.text = HeightArray[row]
            HeightPick.hidden = true
        }
    }
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if(pickerView.tag == 0){
            var myTitle = NSAttributedString(string: GenderArray[row], attributes: [NSFontAttributeName:UIFont(name:layout.HelveticaTitle, size: 10.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            return myTitle

        }else if(pickerView.tag == 1){
            var myTitle = NSAttributedString(string: AgeArray[row], attributes: [NSFontAttributeName:UIFont(name:layout.HelveticaTitle, size: 10.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            return myTitle
        }else if(pickerView.tag == 2){
            var myTitle = NSAttributedString(string: WeightArray[row], attributes: [NSFontAttributeName:UIFont(name:layout.HelveticaTitle, size: 10.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            return myTitle
        }else{
            var myTitle = NSAttributedString(string: HeightArray[row], attributes: [NSFontAttributeName:UIFont(name:layout.HelveticaTitle, size: 10.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            return myTitle
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if(textField.tag == 0){
            GenderPick.hidden = false
        }else if(textField.tag == 1){
            AgePick.hidden = false
        }else if(textField.tag == 2){
            WeightPick.hidden = false
        }else{
            HeightPick.hidden = false
        }
        return false
    }
    
    func healthKitConfirmBtn(sender:UIButton){
        //segue
        performSegueWithIdentifier("HealthKitToInformation", sender: self)
    }
    // AutoLayoutConstraint()
    func AutoLayoutConstraint(){
        //GenderImageView
        GenderImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var GenderImageViewConstraintWidth = NSLayoutConstraint(item: self.GenderImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:0, constant:registerViewLayout.iconWidth)
        var GenderImageViewConstraintHeight = NSLayoutConstraint(item: self.GenderImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:registerViewLayout.iconWidth)
        var GenderImageViewConstraintX = NSLayoutConstraint(item: self.GenderImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var GenderImageViewConstraintY = NSLayoutConstraint(item: self.GenderImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Top, multiplier:1, constant:registerViewLayout.textFieldTitleMarginTop-25.0)
        
        //GenderLabel
        GenderLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var GenderLabelConstraintX = NSLayoutConstraint(item: self.GenderLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.GenderImageView, attribute: NSLayoutAttribute.Right, multiplier:1, constant:registerViewLayout.labelNameMarginLeft)
        var GenderLabelConstraintY = NSLayoutConstraint(item: self.GenderLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.GenderImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        //GenderTextField
        GenderTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var GenderTextFieldConstraintWidth = NSLayoutConstraint(item: self.GenderTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var GenderTextFieldConstraintHeight = NSLayoutConstraint(item: self.GenderTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var GenderTextFieldConstraintX = NSLayoutConstraint(item: self.GenderTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var GenderTextFieldConstraintY = NSLayoutConstraint(item: self.GenderTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.GenderImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:registerViewLayout.textFieldMarginTop)
        
       //AgeImageView
        AgeImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var AgeImageViewConstraintWidth = NSLayoutConstraint(item: self.AgeImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:0, constant:registerViewLayout.iconWidth)
        var AgeImageViewConstraintHeight = NSLayoutConstraint(item: self.AgeImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:registerViewLayout.iconWidth)
        var AgeImageViewConstraintX = NSLayoutConstraint(item: self.AgeImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var AgeImageViewConstraintY = NSLayoutConstraint(item: self.AgeImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.GenderTextField, attribute: NSLayoutAttribute.Top, multiplier:1, constant:registerViewLayout.textFieldPadding)
        //AgeLabel
        AgeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var AgeLabelConstraintX = NSLayoutConstraint(item: self.AgeLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.AgeImageView, attribute: NSLayoutAttribute.Right, multiplier:1, constant:registerViewLayout.labelNameMarginLeft)
        var AgeLabelConstraintY = NSLayoutConstraint(item: self.AgeLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.AgeImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        //PasswordTextField
        AgeTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var AgeTextFieldConstraintWidth = NSLayoutConstraint(item: self.AgeTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var AgeTextFieldConstraintHeight = NSLayoutConstraint(item: self.AgeTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var AgeTextFieldConstraintX = NSLayoutConstraint(item: self.AgeTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var AgeTextFieldConstraintY = NSLayoutConstraint(item: self.AgeTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.AgeImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:registerViewLayout.textFieldMarginTop)
        
        //WeightImageView
        WeightImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var WeightImageViewConstraintWidth = NSLayoutConstraint(item: self.WeightImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:0, constant:registerViewLayout.iconWidth)
        var WeightImageViewConstraintHeight = NSLayoutConstraint(item: self.WeightImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:registerViewLayout.iconWidth)
        var WeightImageViewConstraintX = NSLayoutConstraint(item: self.WeightImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var WeightImageViewConstraintY = NSLayoutConstraint(item: self.WeightImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.AgeTextField, attribute: NSLayoutAttribute.Top, multiplier:1, constant:registerViewLayout.textFieldPadding)
        
        //WeightLabel
        WeightLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var WeightLabelConstraintX = NSLayoutConstraint(item: self.WeightLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.WeightImageView, attribute: NSLayoutAttribute.Right, multiplier:1, constant:registerViewLayout.labelNameMarginLeft)
        var WeightLabelConstraintY = NSLayoutConstraint(item: self.WeightLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.WeightImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        //WeightTextField
        WeightTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var WeightTextFieldConstraintWidth = NSLayoutConstraint(item: self.WeightTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var WeightTextFieldConstraintHeight = NSLayoutConstraint(item: self.WeightTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var WeightTextFieldConstraintX = NSLayoutConstraint(item: self.WeightTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var WeightTextFieldConstraintY = NSLayoutConstraint(item: self.WeightTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.WeightImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:registerViewLayout.textFieldMarginTop)
        
        
        //HeightImageView
        HeightImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var HeightImageViewConstraintWidth = NSLayoutConstraint(item: self.HeightImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:0, constant:registerViewLayout.iconWidth)
        var HeightImageViewConstraintHeight = NSLayoutConstraint(item: self.HeightImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant:registerViewLayout.iconWidth)
        var HeightImageViewConstraintX = NSLayoutConstraint(item: self.HeightImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var HeightImageViewConstraintY = NSLayoutConstraint(item: self.HeightImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.WeightTextField, attribute: NSLayoutAttribute.Top, multiplier:1, constant:registerViewLayout.textFieldPadding)
        
        //WeightLabel
        HeightLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var HeightLabelConstraintX = NSLayoutConstraint(item: self.HeightLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.HeightImageView, attribute: NSLayoutAttribute.Right, multiplier:1, constant:registerViewLayout.labelNameMarginLeft)
        var HeightLabelConstraintY = NSLayoutConstraint(item: self.HeightLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.HeightImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        //HeightTextField
        HeightTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        var HeightTextFieldConstraintWidth = NSLayoutConstraint(item: self.HeightTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var HeightTextFieldConstraintHeight = NSLayoutConstraint(item: self.HeightTextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.textFieldHeight)
        var HeightTextFieldConstraintX = NSLayoutConstraint(item: self.HeightTextField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var HeightTextFieldConstraintY = NSLayoutConstraint(item: self.HeightTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.HeightImageView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:registerViewLayout.textFieldMarginTop)
        
        // HealthKitBtn
        
        HealthKitBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var HealthKitBtnConstraintWidth = NSLayoutConstraint(item: self.HealthKitBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Width, multiplier:0.3, constant:0)
        var HealthKitBtnConstraintHeight = NSLayoutConstraint(item: self.HealthKitBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.LongButtonHeight)
        var HealthKitBtnConstraintX = NSLayoutConstraint(item: self.HealthKitBtn, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.HeightTextField, attribute: NSLayoutAttribute.Right, multiplier:1, constant:0)
        var HealthKitBtnConstraintY = NSLayoutConstraint(item: self.HealthKitBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.HeightTextField, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:30.0)
        
        GenderPick.setTranslatesAutoresizingMaskIntoConstraints(false)
        var GenderPickConstraintX = NSLayoutConstraint(item: self.GenderPick, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:0)
        var GenderPickConstraintY = NSLayoutConstraint(item: self.GenderPick, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        AgePick.setTranslatesAutoresizingMaskIntoConstraints(false)
        var AgePickConstraintX = NSLayoutConstraint(item: self.AgePick, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:0)
        var AgePickConstraintY = NSLayoutConstraint(item: self.AgePick, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        WeightPick.setTranslatesAutoresizingMaskIntoConstraints(false)
        var WeightPickConstraintX = NSLayoutConstraint(item: self.WeightPick, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:0)
        var WeightPickConstraintY = NSLayoutConstraint(item: self.WeightPick, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        HeightPick.setTranslatesAutoresizingMaskIntoConstraints(false)
        var HeightPickConstraintX = NSLayoutConstraint(item: self.HeightPick, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:0)
        var HeightPickConstraintY = NSLayoutConstraint(item: self.HeightPick, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        
        
        
        view.addConstraint(GenderImageViewConstraintHeight)
        view.addConstraint(GenderImageViewConstraintWidth)
        view.addConstraint(GenderImageViewConstraintX)
        view.addConstraint(GenderImageViewConstraintY)
        view.addConstraint(GenderLabelConstraintX)
        view.addConstraint(GenderLabelConstraintY)
        view.addConstraint(GenderTextFieldConstraintHeight)
        view.addConstraint(GenderTextFieldConstraintWidth)
        view.addConstraint(GenderTextFieldConstraintX)
        view.addConstraint(GenderTextFieldConstraintY)
        
        view.addConstraint(AgeImageViewConstraintHeight)
        view.addConstraint(AgeImageViewConstraintWidth)
        view.addConstraint(AgeImageViewConstraintX)
        view.addConstraint(AgeImageViewConstraintY)
        view.addConstraint(AgeLabelConstraintX)
        view.addConstraint(AgeLabelConstraintY)
        view.addConstraint(AgeTextFieldConstraintHeight)
        view.addConstraint(AgeTextFieldConstraintWidth)
        view.addConstraint(AgeTextFieldConstraintX)
        view.addConstraint(AgeTextFieldConstraintY)
        
        view.addConstraint(WeightImageViewConstraintHeight)
        view.addConstraint(WeightImageViewConstraintWidth)
        view.addConstraint(WeightImageViewConstraintX)
        view.addConstraint(WeightImageViewConstraintY)
        view.addConstraint(WeightLabelConstraintX)
        view.addConstraint(WeightLabelConstraintY)
        view.addConstraint(WeightTextFieldConstraintHeight)
        view.addConstraint(WeightTextFieldConstraintWidth)
        view.addConstraint(WeightTextFieldConstraintX)
        view.addConstraint(WeightTextFieldConstraintY)
        
        view.addConstraint(HeightImageViewConstraintHeight)
        view.addConstraint(HeightImageViewConstraintWidth)
        view.addConstraint(HeightImageViewConstraintX)
        view.addConstraint(HeightImageViewConstraintY)
        view.addConstraint(HeightLabelConstraintX)
        view.addConstraint(HeightLabelConstraintY)
        view.addConstraint(HeightTextFieldConstraintHeight)
        view.addConstraint(HeightTextFieldConstraintWidth)
        view.addConstraint(HeightTextFieldConstraintX)
        view.addConstraint(HeightTextFieldConstraintY)
        
        view.addConstraint(HealthKitBtnConstraintHeight)
        view.addConstraint(HealthKitBtnConstraintWidth)
        view.addConstraint(HealthKitBtnConstraintX)
        view.addConstraint(HealthKitBtnConstraintY)
        
        view.addConstraint(GenderPickConstraintX)
        view.addConstraint(GenderPickConstraintY)
        
        view.addConstraint(AgePickConstraintX)
        view.addConstraint(AgePickConstraintY)
        
        view.addConstraint(HeightPickConstraintX)
        view.addConstraint(HeightPickConstraintY)
        
        view.addConstraint(WeightPickConstraintX)
        view.addConstraint(WeightPickConstraintY)
    }
    
}
