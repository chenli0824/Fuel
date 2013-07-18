//
//  CLAddFuelViewController.h
//  Fuel
//
//  Created by Chenli on 13-7-17.
//  Copyright (c) 2013年 chenli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLAddFuelViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UITextField *totalPriceField;
@property (weak, nonatomic) IBOutlet UITextField *totalMileageField;
@property (weak, nonatomic) IBOutlet UIButton *fuelTypeButton;

@end
