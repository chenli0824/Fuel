//
//  DBController.h
//  DBController
//
//  Created by 立 陈 on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMResultSet.h"

@interface BaseDB : NSObject{
    FMDatabase *fmdb;
}

@property (nonatomic,retain) FMDatabase *fmdb;

-(void)openDB;//打开数据库
-(void)closeDB;//关闭数据库
-(void)openDBMS; //打开数据管理数据库 为了不与Caches.db相关 单独创建
-(void)createTable:(NSString *)tableName columns:(NSString *)columnsName;//建立数据库表

-(BOOL) tableExists:(NSString *)tableName;//查看表是否存在

/*
 插入表数据
 tableName:数据库表名称
 */
-(void)insertTableValues:(NSString *)tableName values:(NSArray *)Values;

-(void)deleteAll:(NSString *)tableName;

-(void)deleteForColumn:(NSString *)columnName value:(NSString *)v tableName:(NSString *)name;

-(void)deleteSQLString:(NSString *)condition tableName:(NSString *)name;


- (void)executeSQL:(NSString *)sql; 

-(NSMutableArray *)selectAll:(NSString *)tableName;

-(NSMutableArray *) selectForColumn:(NSString *)columnName value:(NSString *)v tableName:(NSString *)name;

-(NSMutableArray *) selectForNotColumn:(NSString *)columnName value:(NSString *)v tableName:(NSString *)name;

-(void)updateForColumn:(NSString *)columnName value:(NSString *)v tableName:(NSString *)name whereColumn:(NSString *)where whereValue:(NSString *)whereV;

//-(NSMutableArray *)selectSequence:(NSString *)dl maxid:(NSString *)mid table:(NSString *)tableName;
-(NSMutableArray *)selectSequence:(NSString *)sql;



/*
 插入表数据
 tableName:数据库表名称
 */
-(void)insertTableValues:(NSString *)tableName Values:(id)values;

@end
