//
//  PJViewController.m
//  PJAlertView
//
//  Created by hetane on 16/11/21.
//  Copyright © 2016年 周鹏钜. All rights reserved.
//

#import "PJViewController.h"


@interface PJViewController ()

@end

@implementation PJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//           [MBProgressHUD hideHUDForView:self.view animated:YES];
//        });
//    });
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 350, WIDTH-30, 60)];
    [self.view addSubview:btn];
    
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 8;
    btn.layer.borderColor = [UIColor yellowColor].CGColor;
    
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"%@", [NSThread currentThread]);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSLog(@"11%@", [NSThread currentThread]);
    }];
}

- (void)btnClick {
    
    NSLog(@"********************************");

//    PJAlertView *alertView = [[PJAlertView alloc] init];
//    
//    [alertView show];
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
    });
    
    
}

@end
