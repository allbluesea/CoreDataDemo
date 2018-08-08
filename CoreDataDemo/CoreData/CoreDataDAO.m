//
//  CoreDataDAO.m
//
//

#import "CoreDataDAO.h"
#import "User+CoreDataClass.h"
#import "CoreDataManager.h"
#import "GlobalUser.h"
#import <MJExtension.h>

#define CD_MANAGER [CoreDataManager sharedManager]

NSString * const UserEntity = @"User";

@implementation CoreDataDAO

+ (BOOL)insertModelWithDictionary:(NSDictionary *)dict {
    User *user = [NSEntityDescription insertNewObjectForEntityForName:UserEntity inManagedObjectContext:CD_MANAGER.managedObjectContext];
    [user mj_setKeyValues:dict];
    
    // TODO: 去重处理...
//    if (condition) {
//
//    }
    
    [GlobalUser parseModel:user];
    
    NSError *err;
    BOOL ret = [CD_MANAGER.managedObjectContext save:&err];
    if (!ret) {
        NSLog(@"insert err: %@", err.localizedDescription);
    }
    return ret;
}

+ (void)deleteModelWithCondition:(NSString *)condition {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:UserEntity inManagedObjectContext:CD_MANAGER.managedObjectContext];
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityDescription.name];
    // 设置查询条件
    if (condition) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:condition];
        [req setPredicate:predicate];
    }
    
    NSError *err;
    NSArray *list = [CD_MANAGER.managedObjectContext executeFetchRequest:req error:&err];
    for (NSManagedObject *object in list) {
        [CD_MANAGER.managedObjectContext deleteObject:object];
    }
    [CD_MANAGER.managedObjectContext save:&err];
}

+ (void)deleteModel {
    [self deleteModelWithCondition:[NSString stringWithFormat:@"user_id==%@", [GlobalUser sharedInstance].user_id]];
}


+ (BOOL)updateValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSString class]]) {
        if (!value) {
            return NO;
        }
    }
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:UserEntity inManagedObjectContext:CD_MANAGER.managedObjectContext];
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityDescription.name];
    // 设置查询条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id==%@", [GlobalUser sharedInstance].user_id];
    [req setPredicate:predicate];
    NSError *err;
    NSArray *list = [CD_MANAGER.managedObjectContext executeFetchRequest:req error:&err];
    NSManagedObject *object = list.lastObject;
    @try {
        //更新后要进行保存，否则没更新
        if ([[object valueForKey:key] isKindOfClass:[NSString class]]) {
            [object setValue:value forKey:key];
        }else{
            [object setValue:@([value integerValue]) forKey:key];
        }
    } @catch (NSException *exception) {
        //未赋值之前[object valueForKey:key]有可能为nil，将会crash
        NSLog(@"Coredata update err: %@", exception.reason);
        return NO;
    }
    
    BOOL ret = [CD_MANAGER.managedObjectContext save:&err];
    if (!ret) {
        NSLog(@"Coredata update err: %@", err.localizedDescription);
    }
    
    return ret;
}

+ (void)configModel {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:UserEntity inManagedObjectContext:CD_MANAGER.managedObjectContext];
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityDescription.name];
    NSError *err;
    NSArray *list = [CD_MANAGER.managedObjectContext executeFetchRequest:req error:&err];
    User *user = list.lastObject;
    [GlobalUser parseModel:user];
}


@end
