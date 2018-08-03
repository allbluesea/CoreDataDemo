//
//  GlobalUser.m
//  CoreDataDemo
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GlobalUser.h"
#import <MJExtension.h>

@implementation GlobalUser

+ (GlobalUser *)sharedInstance {
    static GlobalUser *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [self new];
    });
    
    return user;
}

+ (void)parseModel:(NSManagedObject *)model {
    GlobalUser *user = [self sharedInstance];
    [user mj_setKeyValues:[model mj_JSONObject]];
}

@end
