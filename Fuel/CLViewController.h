//
//  CLViewController.h
//  Fuel
//
//  Created by Chenli on 13-7-15.
//  Copyright (c) 2013年 chenli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *mileageLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTypeLabel;
@property (weak, nonatomic) IBOutlet UIView *carView;
@property (weak, nonatomic) IBOutlet UITableView *carTableView;
@property (weak, nonatomic) IBOutlet UITableView *fuelTableView;

@end
