//
//  CLAddCarViewController.m
//  Fuel
//
//  Created by Chenli on 13-7-15.
//  Copyright (c) 2013年 chenli. All rights reserved.
//

#import "CLAddCarViewController.h"
#import "BaseDB.h"

@interface CLAddCarViewController ()

@end

@implementation CLAddCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)closeAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)saveAction:(id)sender {
    BaseDB *baseDB = [[BaseDB alloc] init];
    [baseDB openDB];
    if (![baseDB tableExists:@"carInfo"]) {
        [baseDB createTable:@"carInfo" columns:@"ID INTEGER PRIMARY KEY,name TEXT,mileage TEXT,login TEXT"];
    }
    
    [baseDB insertTableValues:@"carInfo" Values:[NSDictionary dictionaryWithObjectsAndKeys:@"NULL",@"ID",
                                                                                            _nameTypeField.text,@"name",
                                                                                            _mileageField.text,@"mileage",
                                                                                                            @"YES",@"login",nil]];
    [baseDB closeDB];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameTypeField:nil];
    [self setMileageField:nil];
    [super viewDidUnload];
}
@end
