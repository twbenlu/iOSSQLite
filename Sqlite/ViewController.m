//
//  ViewController.m
//  Sqlite
//
//  Created by benlu on 1/29/14.
//  Copyright (c) 2014 benlu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mytable.dataSource = self;
    self.mytable.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
     NSString *dst = [NSString stringWithFormat:@"%@/Documents/sample.sqlite",NSHomeDirectory()];
    
    if(sqlite3_open([dst UTF8String], &db) != SQLITE_OK){
        db = nil;
        NSLog(@"資料庫連線失敗");
    }else{
        NSLog(@"資料庫連線成功");
    }
    
     NSString *sql = [NSString stringWithFormat:@"select * from test"];
     sqlite3_stmt *statement = [self executeQuery:sql];
     TabelDatas = [self statementtoMSarray:statement];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mybtn_click:(id)sender {
//    NSString *insertProgrammeSql = @"INSERT INTO test (test001) VALUES ('test')";
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO test (test001) VALUES ('%@')",self.mytxt.text];
    char *errMsg;
//    sqlite3_exec(db, [sql cStringUsingEncoding:NSUTF8StringEncoding], NULL, NULL, &errMsg);
    if(sqlite3_exec(db, [sql cStringUsingEncoding:NSUTF8StringEncoding], NULL, NULL, &errMsg) == SQLITE_OK){
        NSLog(@"寫入資料庫成功, %s", errMsg);
    }else{
        NSLog(@"寫入資料庫失敗, %s", errMsg);
    }

    
    NSString *sql2 = [NSString stringWithFormat:@"select * from test"];
    sqlite3_stmt *statement = [self executeQuery:sql2];
    TabelDatas = [self statementtoMSarray:statement];
    [self.mytable reloadData];
    
    NSLog(@"寫入按鈕執行完成");
}



//執行查詢指令 並且回傳一個 statement集合
- (sqlite3_stmt *) executeQuery:(NSString *) query{
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil);
    return statement;
}


//
- (NSArray *) statementtoMSarray:(sqlite3_stmt *) sqlstmt{
    TabelDatas = [[NSMutableArray alloc]init];
    NSString *data;
    while (sqlite3_step(sqlstmt) == SQLITE_ROW) {
        data = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlstmt,0)];
        [TabelDatas addObject:data];
    }
    return TabelDatas;
}

//這個方法是用來指定有多少的Section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

//這個方法是用來指定每個Section裡面有多少Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
    return [TabelDatas count];
}

//用來產生Cell的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //Configure the cell.
    cell.textLabel.text = [TabelDatas objectAtIndex:[indexPath row]];
    return cell;
}



@end
