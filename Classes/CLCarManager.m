//
//  CLCarManager.m
//  Fuel
//
//  Created by Chenli on 13-7-17.
//  Copyright (c) 2013年 chenli. All rights reserved.
//

#import "CLCarManager.h"
#import "BaseDB.h"

@implementation CLCarManager

+(NSDictionary *)readCurrCarInfo{
    NSDictionary *dict;
    BaseDB *baseDB = [[BaseDB alloc] init];
    [baseDB openDB];
    
      dict = [NSDictionary dictionaryWithDictionary:[baseDB selectForColumn:@"login" value:@"YES" tableName:@"carInfo"]];
    
    [baseDB closeDB];
    
    return dict;
}

+(void)saveNewCarInfo:(NSDictionary *)dict{
    BaseDB *baseDB = [[BaseDB alloc] init];
    [baseDB openDB];
    if (![baseDB tableExists:@"carInfo"]) {
        [baseDB createTable:@"carInfo" columns:@"ID INTEGER PRIMARY KEY,name TEXT,mileage TEXT,login TEXT"];
    }
    
    if ([self readCurrCarInfo]!= nil) {
        [baseDB updateForColumn:@"login" value:@"NO" tableName:@"carInfo" whereColumn:@"login" whereValue:@"YES"];
    }
    
    [baseDB insertTableValues:@"carInfo" Values:dict];
    
    [baseDB closeDB];
}

@end
