//
//  AppDelegate.m
//  Sqlite
//
//  Created by benlu on 1/29/14.
//  Copyright (c) 2014 benlu. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //將資料庫檔案複製到具有寫入權限的目錄
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString *src = [[NSBundle mainBundle]pathForResource:@"sample" ofType:@"sqlite"];
    NSString *dst = [NSString stringWithFormat:@"%@/Documents/sample.sqlite",NSHomeDirectory()];
    //APP啓用的時候在@/Documents 沒有資料庫，所以要從APP裡面把sample.sqlite資料庫拷貝到 @/Documents/ 資料夾下
    //拷貝完資料庫後,刪除掉App裡面的資料庫檢查目的地的檔案是否存在，如果不存在則複製資料庫
    //    if(![fm fileExistsAtPath:dst]){
    //    	[fm copyItemAtPath:src toPath:dst error:nil];
    //        [fm removeItemAtPath:src error:nil];
    //    }
    
    //每次都把資料庫Copy到Document資料夾下
    [fm removeItemAtPath:dst error:nil];
    [fm copyItemAtPath:src toPath:dst error:nil];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
