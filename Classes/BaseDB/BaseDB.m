//
//  DBController.m
//  DBController
//
//  Created by 立 陈 on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseDB.h"

@implementation BaseDB
@synthesize fmdb;

- (void)dealloc{
    self.fmdb   = nil;
}

-(void)openDB{
    NSString *documentsDirectory =NSHomeDirectory();
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"/Library/Caches/Caches.db"];
    NSFileManager *fileManager=[[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:path]) {
        fmdb=[[FMDatabase alloc] initWithPath:path];
        if ([fmdb open]) {
            NSLog(@"数据库打开成功!");
        }
    
    }else{
        fmdb=[[FMDatabase alloc] initWithPath:path];
        if ([fmdb open]) {
            NSLog(@"创建了数据库并打开数据库成功!");
        }
    }
    fileManager = nil;
}

-(void)openDBMS{
    NSString *documentsDirectory =NSHomeDirectory();
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"/Library/Dbms"];
    NSFileManager *fileManager=[[NSFileManager alloc] init];
    if(![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [path stringByAppendingFormat:@"/Dbms.db"];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        fmdb=[[FMDatabase alloc] initWithPath:filePath];
        if ([fmdb open]) {
            NSLog(@"数据库打开成功!");
        }
        
    }else{
        fmdb=[[FMDatabase alloc] initWithPath:filePath];
        if ([fmdb open]) {
            NSLog(@"创建了数据库并打开数据库成功!");
        }
    }
    fileManager = nil;
}


-(void)closeDB{
    [fmdb close];
}

-(BOOL) tableExists:(NSString *)tableName{
    return [fmdb tableExists:tableName];
}


-(void)deleteAll:(NSString *)tableName{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM %@",tableName];
    [fmdb executeUpdate:sql];
}



-(void) deleteForColumn:(NSString *)columnName value:(NSString *)v tableName:(NSString *)name{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@='%@'",name,columnName,v];
    [fmdb executeUpdate:sql];
}

- (void)deleteSQLString:(NSString *)condition tableName:(NSString *)name{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",name,condition];
    NSLog(@"%@",sql);
    [fmdb executeUpdate:sql];
}



-(void)createTable:(NSString *)tableName columns:(NSString *)columnsName{
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE %@ (%@)",tableName,columnsName];
    [fmdb executeUpdate:sql];
}

-(void)insertTableValues:(NSString *)tableName values:(NSArray *)Values{
    NSMutableString *sql=[[NSMutableString alloc] init];
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithArray:Values];
    [sql appendFormat:@"INSERT INTO %@ VALUES(",tableName];
    for (int i=0; i<[Values count]; i++) {
        if (i==[Values count]-1) {
            [sql appendFormat:@"?)"];
        }else{
            [sql appendFormat:@"?,"];
        }
        
    }
    
    NSString *sq = @"INSERT INTO carInfo VALUES(NULL,'chenli','10000')";
    [fmdb executeUpdate:sq];

    
//    [fmdb executeUpdate:sql withArgumentsInArray:tempArray];
    sql = nil;
    tempArray = nil;
}

- (void)executeSQL:(NSString *)sql{
    [fmdb executeUpdate:sql];
}


-(NSMutableArray *)selectAll:(NSString *)tableName{
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    FMResultSet *rs=[fmdb executeQuery:sql];
    NSMutableArray *list=[[NSMutableArray alloc] init];
    
    while ([rs next]) {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        for (int i=0; i<[rs columnCount]; i++) {
            [temp addEntriesFromDictionary:[NSDictionary 
                                            dictionaryWithObject:[rs stringForColumn:[rs columnNameForIndex:i]] 
                                            forKey:[rs columnNameForIndex:i]]];
        }
        [list addObject:temp];
        temp = nil;
    }
    
    return list;
}





-(id)selectForColumn:(NSString *)columnName value:(NSString *)v tableName:(NSString *)name{
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@='%@'",name,columnName,v];
    FMResultSet *rs=[fmdb executeQuery:sql];
    NSMutableArray *list=[[NSMutableArray alloc] init];
    
    while ([rs next]) {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        for (int i=0; i<[rs columnCount]; i++) {
            [temp addEntriesFromDictionary:[NSDictionary 
                                            dictionaryWithObject:[rs stringForColumn:[rs columnNameForIndex:i]] 
                                            forKey:[rs columnNameForIndex:i]]];
        }
        [list addObject:temp];
        temp = nil;
    }
    
    
    if ([list count]>1) {
        return list;
    }else if([list count] == 1){
        return list[0];
    }else{
        return nil;
    }
    
    
}

-(NSMutableArray *) selectForNotColumn:(NSString *)columnName value:(NSString *)v tableName:(NSString *)name{
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@!='%@'",name,columnName,v];
    FMResultSet *rs=[fmdb executeQuery:sql];
    NSMutableArray *list=[[NSMutableArray alloc] init];
    
    while ([rs next]) {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        for (int i=0; i<[rs columnCount]; i++) {
            [temp addEntriesFromDictionary:[NSDictionary 
                                            dictionaryWithObject:[rs stringForColumn:[rs columnNameForIndex:i]] 
                                            forKey:[rs columnNameForIndex:i]]];
        }
        [list addObject:temp];
        temp = nil;
    }
    
    return list ;
}





-(void)updateForColumn:(NSString *)columnName value:(NSString *)v tableName:(NSString *)name whereColumn:(NSString *)where whereValue:(NSString *)whereV{
    NSString *sql=[NSString stringWithFormat:@"UPDATE %@ SET %@='%@' WHERE %@='%@'",name,columnName,v,where,whereV];
    [fmdb executeUpdate:sql];
}



-(NSMutableArray *)selectSequence:(NSString *)sql{

    FMResultSet *rs=[fmdb executeQuery:sql];
   
    NSMutableArray *list=[[NSMutableArray alloc] init];
    
    while ([rs next]) {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        for (int i=0; i<[rs columnCount]; i++) {
            [temp addEntriesFromDictionary:[NSDictionary 
                                            dictionaryWithObject:[rs stringForColumn:[rs columnNameForIndex:i]] 
                                            forKey:[rs columnNameForIndex:i]]];
            
        }
        [list addObject:temp];
        temp = nil;
    }
    
    return list;    

}


-(void)insertTableValues:(NSString *)tableName Values:(id)values{

    
    NSMutableArray *columnNameArray = [NSMutableArray array];
    
    NSString *s = [NSString stringWithFormat:@"SELECT * FROM '%@'",tableName];
    FMResultSet *rs = [fmdb executeQuery:s];
        for (int i = 0 ; i<[rs columnCount]; i++) {
            [columnNameArray addObject:[rs columnNameForIndex:i]];
        }
    
    NSMutableString *sql=[NSMutableString string];

    if ([values isKindOfClass:[NSArray class]] ||
        [values isKindOfClass:[NSMutableArray class]]) {
        [sql appendFormat:@"INSERT INTO %@ VALUES(",tableName];
        
        for (int i=0; i<[values count]; i++) {

            if ([values[i] isEqualToString:@"NULL"]) {
                [sql appendFormat:@"NULL"];
            
            }else if([values[i] isKindOfClass:[NSString class]]){
                [sql appendFormat:@"'%@'",values[i]];
            
            }else{
                [sql appendFormat:@"%@",values[i]];
            }
        
            if (i==[values count]-1) {
                [sql appendFormat:@")"];
                
            }else{
                [sql appendFormat:@","];
            }
        }
    }
    
    
    
    if ([values isKindOfClass:[NSDictionary class]] ||
        [values isKindOfClass:[NSMutableDictionary class]]) {
        [sql appendFormat:@"INSERT INTO %@ VALUES(",tableName];
        
        for (int i = 0;i<[columnNameArray count];i++) {
                
            if ([[values objectForKey:columnNameArray[i]] isEqualToString:@"NULL"]) {
                [sql appendFormat:@"NULL"];
                
            }else if([values[columnNameArray[i]] isKindOfClass:[NSString class]]){
                
                [sql appendFormat:@"'%@'",[values objectForKey:columnNameArray[i]]];
                
            }else{
                [sql appendFormat:@"%@",[values objectForKey:columnNameArray[i]]];
            }
            
            if (i == [columnNameArray count]-1) {
                [sql appendFormat:@")"];
                
            }else{
                [sql appendFormat:@","];
            }
        }
    }
    
    [fmdb executeUpdate:sql];
    
    [columnNameArray removeAllObjects];
    columnNameArray = nil;
    sql = nil;

}



@end
