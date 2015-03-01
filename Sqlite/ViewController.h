//
//  ViewController.h
//  Sqlite
//
//  Created by benlu on 1/29/14.
//  Copyright (c) 2014 benlu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    //類別變數
    sqlite3* db;
    //動態陣列：用來暫存ＳＱＬ指令取出的master.eng資料(例如：)
    NSMutableArray *TabelDatas;
}

//新增資料的textbox
@property (weak, nonatomic) IBOutlet UITextField *mytxt;
//按鈕事件
- (IBAction)mybtn_click:(id)sender;

//UItable與Controller連結的IBoutlet
@property (weak, nonatomic) IBOutlet UITableView *mytable;

//執行SQL指令，並且回傳statement(RS)物件
- (sqlite3_stmt *) executeQuery:(NSString *) query;
- (NSMutableArray *) statementtoMSarray:(sqlite3_stmt *) sqlstmt;




@end
