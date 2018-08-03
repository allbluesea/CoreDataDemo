//
//  CoreDataTool.h
//  Demo
//
//  Created by bxd on 16/5/19.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

/* 管理对象上下文 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
/* 管理对象模型 */
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
/* 持久化存储协调器 */
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
