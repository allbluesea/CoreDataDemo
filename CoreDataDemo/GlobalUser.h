//
//  GlobalUser.h
//  CoreDataDemo
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/NSManagedObject.h>

@interface GlobalUser : NSObject

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, strong) NSString *user_name;

// 单例
+ (GlobalUser *)sharedInstance;

+ (void)parseModel:(NSManagedObject *)model;

@end
