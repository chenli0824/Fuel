//
//  CLCarManager.h
//  Fuel
//
//  Created by Chenli on 13-7-17.
//  Copyright (c) 2013年 chenli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCarManager : NSObject


+(NSDictionary *)readLoginedCarInfo;          //读取当前车辆基础信息

+(void)saveNewCarInfo:(NSDictionary *)dict;  //保存新车辆基础信息


+(void)saveFuelInfo:(NSDictionary *)dict;

@end
