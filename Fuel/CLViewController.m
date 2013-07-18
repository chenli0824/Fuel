//
//  CLViewController.m
//  Fuel
//
//  Created by Chenli on 13-7-15.
//  Copyright (c) 2013年 chenli. All rights reserved.
//

#import "CLViewController.h"
#import "CLAddCarViewController.h"
#import "CLCarManager.h"
#import "CLAddFuelViewController.h"
@interface CLViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableDictionary *dict;
    NSMutableArray *carArray;
    BOOL carViewShow;
}

@end

@implementation CLViewController

- (void)viewDidLoad
{
    carViewShow = NO;
    carArray = [NSMutableArray array];
    dict = [NSMutableDictionary dictionary];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)readAllCarInfo{
    [carArray removeAllObjects];
    for (NSDictionary *dic in [CLCarManager allCarInfo]) {
        [carArray addObject:dic];
    }
    
    [self.carTableView reloadData];
}



-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"dict:%@",[CLCarManager readCurrCarInfo]);
    [dict addEntriesFromDictionary:[CLCarManager readCurrCarInfo]];
    self.mileageLabel.text = [NSString stringWithFormat:@"%@ kM",dict[@"mileage"]];
    self.nameTypeLabel.text = dict[@"name"];
    
    [self readAllCarInfo];
    
    if (carViewShow) {
        [self showCarViewAction:nil];
    }
    
    [super viewWillAppear:animated];
}

- (IBAction)showCarViewAction:(id)sender {
    
    if (_carView.frame.origin.x == self.view.frame.size.width) {
        carViewShow = YES;
        CGRect carFrame = _carView.frame;
        carFrame.origin.x = self.view.frame.size.width - _carView.frame.size.width;
        self.carView.frame = carFrame;
    }else{
        carViewShow = NO;
        CGRect carFrame = _carView.frame;
        carFrame.origin.x = self.view.frame.size.width;
        self.carView.frame = carFrame;
    }
}

- (IBAction)addCarAction:(id)sender {
    CLAddCarViewController *addCarView = [[CLAddCarViewController alloc] init];
    
    [self presentModalViewController:addCarView animated:YES];
}

- (IBAction)addFuelAction:(id)sender {
    CLAddFuelViewController *fuelView = [[CLAddFuelViewController alloc] init];
    [self presentModalViewController:fuelView animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [carArray count];
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.carTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = carArray[indexPath.row][@"name"];
    
    
    return cell;
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
    [self setCarTableView:nil];
    [super viewDidUnload];
}
@end
