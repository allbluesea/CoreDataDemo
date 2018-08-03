//
//  ViewController.m
//  CoreDataDemo
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataDAO.h"
#import "GlobalUser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSDictionary *user = @{@"user_id": @"3", @"user_name": @"ls"};
//    [CoreDataDAO insertModelWithDictionary:user];
    [CoreDataDAO configModel];
    
    NSLog(@"%@ --- ", [GlobalUser sharedInstance].user_name);
    
    [CoreDataDAO deleteModelWithCondition:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
