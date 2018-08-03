//
//  CoreDataDAO.h
//  XYIOT
//
//  Created by stary on 2017/10/31.
//  Copyright © 2017年 XYWL. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString * const UserEntity;

@interface CoreDataDAO : NSObject

/**
 新建模型
 
 @param dict 服务器返回字典
 */
+ (BOOL)insertModelWithDictionary:(NSDictionary *)dict;

/**
 更新模型

 @param value 值
 @param key 键
 @return 更新结果
 */
+ (BOOL)updateValue:(id)value forKey:(NSString *)key;

/**
 删除模型
 */
+ (void)deleteModel;

/**
 通过条件删除模型

 @param condition 条件
 */
+ (void)deleteModelWithCondition:(NSString *)condition;


/**
 配置
 */
+ (void)configModel;

@end
