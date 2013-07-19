//
//  CLAddFuelViewController.m
//  Fuel
//
//  Created by Chenli on 13-7-17.
//  Copyright (c) 2013年 chenli. All rights reserved.
//

#import "CLAddFuelViewController.h"

@interface CLAddFuelViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray *fuelTypeArray;
}

@end

@implementation CLAddFuelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)setDateAction:(id)sender {
    if ([sender tag] == 0) {
        if (_datePickerView.hidden) {
            [self.totalPriceField endEditing:YES];
            [self.totalMileageField endEditing:YES];
            _fuelTypePicker.hidden = YES;
            _datePicker.hidden = NO;
            _datePickerView.hidden = NO;
        
        
        }else{
            _datePickerView.hidden = YES;
        }
    }else{
    
        if (_datePickerView.hidden) {
            [self.totalPriceField endEditing:YES];
            [self.totalMileageField endEditing:YES];
            _fuelTypePicker.hidden = NO;
            _datePicker.hidden = YES;
            _datePickerView.hidden = NO;
        }else{
            _datePickerView.hidden = YES;
        }
    }
    
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [fuelTypeArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return fuelTypeArray[row];
}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{


}




-(void)initData{
    self.datePicker.minimumDate =  [NSDate date];
    [self.datePicker  addTarget:self action: @selector(onDatePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.datePicker setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"zh_CN"]];
    
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    [self.dateButton setTitle:[fmt stringFromDate:[NSDate date]]
                     forState:UIControlStateNormal];
    
    
    fuelTypeArray = [NSArray arrayWithObjects:@"90#",@"93#",@"97#",@"98#",@"0#", nil];
    
}

- (void)onDatePickerChanged: (UIDatePicker *)datePicker {
    
    
    
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    [self.dateButton setTitle:[fmt stringFromDate:datePicker.date]
                     forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)endEditingAction:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)editingBegin:(id)sender {
    if (!self.datePickerView.hidden) {
        self.datePickerView.hidden = YES;
    }
}


-(void)keyboardWillShow:(NSNotification *)notif{
    self.datePickerView.hidden = YES;
//    NSDictionary *info = [notif userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardFrame = [value CGRectValue];
//    [selfchangeScrollViewHeight:keyboardFrame];
}

-(void)changeScrollViewHeight:(CGRect)frame{
    
//    CGRect sframe = self.scrollView.frame;
//    sframe.size.height = self.view.frame.size.height - (self.scrollView.frame.origin.y + frame.size.height);
//    self.scrollView.frame = sframe;
}

-(void)keyboardWillHide:(NSNotification *)notif{
//    CGRect sframe = self.scrollView.frame;
//    sframe.size.height = self.view.frame.size.height - self.scrollView.frame.origin.y;
//    self.scrollView.frame = sframe;
    
}

- (void)viewDidLoad
{
    [self initData];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDatePicker:nil];
    [self setDatePickerView:nil];
    [self setDateButton:nil];
    [self setTotalPriceField:nil];
    [self setTotalMileageField:nil];
    [self setFuelTypeButton:nil];
    [self setFuelTypePicker:nil];
    [super viewDidUnload];
}
@end
