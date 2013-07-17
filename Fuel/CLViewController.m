//
//  CLViewController.m
//  Fuel
//
//  Created by Chenli on 13-7-15.
//  Copyright (c) 2013年 chenli. All rights reserved.
//

#import "CLViewController.h"
#import "CLAddCarViewController.h"
#import "BaseDB.h"
#import "CLCarManager.h"

@interface CLViewController (){
    NSMutableDictionary *dict;
}

@end

@implementation CLViewController

- (void)viewDidLoad
{
    dict = [NSMutableDictionary dictionary];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"dict:%@",[CLCarManager readCurrCarInfo]);
    [dict addEntriesFromDictionary:[CLCarManager readCurrCarInfo]];
    self.mileageLabel.text = [NSString stringWithFormat:@"%@ kM",dict[@"mileage"]];
    self.nameTypeLabel.text = dict[@"name"];
    [super viewWillAppear:animated];
}

- (IBAction)showCarViewAction:(id)sender {
    
    if (_carView.frame.origin.x == self.view.frame.size.width) {
        CGRect carFrame = _carView.frame;
        carFrame.origin.x = self.view.frame.size.width - _carView.frame.size.width;
        self.carView.frame = carFrame;
    }else{
        CGRect carFrame = _carView.frame;
        carFrame.origin.x = self.view.frame.size.width;
        self.carView.frame = carFrame;
    }
}

- (IBAction)addCarAction:(id)sender {
    CLAddCarViewController *addCarView = [[CLAddCarViewController alloc] init];
    
    [self presentModalViewController:addCarView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMileageLabel:nil];
    [self setNameTypeLabel:nil];
    [self setCarView:nil];
    [self setCarTableView:nil];
    [self setFuelTableView:nil];
    [super viewDidUnload];
}
@end
