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

+(NSDictionary *)readLoginedCarInfo{
    NSDictionary *dict;
    BaseDB *baseDB = [[BaseDB alloc] init];
    [baseDB openDB];
    
    id info = [baseDB selectForColumn:@"Login" value:@"YES" tableName:@"carInfo"];
    [baseDB closeDB];
    
    if (info == nil) {
        return nil;
    }else{
        dict = [NSDictionary dictionaryWithDictionary:info];
    }
    return dict;
}

+(void)saveNewCarInfo:(NSDictionary *)dict{
    BaseDB *baseDB = [[BaseDB alloc] init];
    [baseDB openDB];
    if (![baseDB tableExists:@"carInfo"]) {
        [baseDB createTable:@"carInfo" columns:@"ID INTEGER PRIMARY KEY,Name TEXT,TotalMileage TEXT,Login TEXT"];
    }
    
    if ([self readLoginedCarInfo]!= nil) {
        [baseDB updateForColumn:@"Login" value:@"NO" tableName:@"carInfo" whereColumn:@"Login" whereValue:@"YES"];
    }
    
    [baseDB insertTableValues:@"carInfo" Values:dict];
    
    [baseDB closeDB];
}


+(void)saveFuelInfo:(NSDictionary *)dict{
    BaseDB *baseDB = [[BaseDB alloc] init];
    [baseDB openDB];
    if (![baseDB tableExists:@"fuelInfo"]) {
        [baseDB createTable:@"fuelInfo" columns:@"ID INTEGER PRIMARY KEY,CarID TEXT,TotalMileage TEXT,FuelType TEXT,Time TEXT,Price TEXT"];
    }

}

@end
