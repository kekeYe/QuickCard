//
//  MyViewController.m
//  igo
//
//  Created by Destiny on 15/9/22.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import "MyViewController.h"
#import "AFNetworking.h"
#import "loginViewController.h"

@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (weak, nonatomic) IBOutlet UILabel *lblmobile;
@property (weak, nonatomic) IBOutlet UILabel *lblemail;
- (IBAction)btnlogin;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.u_mobile)
    {
        [self.loginbtn setTitle:@"admin" forState:UIControlStateNormal];
        self.loginbtn.enabled = NO;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[NSString stringWithFormat:@"%ld",self.u_mobile] forKey:@"u_mobile"];
        [manager POST:@"http://localhost:8888/igo/users.php?action=select_user" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *arr = (NSArray *)responseObject;
            NSDictionary *dic = arr[0];
            self.lblmobile.text = dic[@"u_mobile"];
            self.lblemail.text = dic[@"u_email"];
        } failure:^(AFHTTPRequestOperation * operation, NSError *error ) {
            NSLog(@"错误%@",error);
        }];
    }
}


- (IBAction)btnlogin {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    loginViewController *loginVC = [sb instantiateViewControllerWithIdentifier:@"loginVC"];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
    loginVC.hidesBottomBarWhenPushed = YES;
}
@end
