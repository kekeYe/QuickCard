//
//  loginVC.m
//  iGou
//
//  Created by administrator on 9/24/15.
//  Copyright © 2015 xingxing. All rights reserved.
//

#import "loginVC.h"
#import "myVC.h"
#import "AFNetworking.h"
@interface loginVC ()
@property (weak, nonatomic) IBOutlet UITextField *u_mobile;
@property (weak, nonatomic) IBOutlet UITextField *u_password;

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *loginbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginbtn.layer.cornerRadius = 10;
    loginbtn.frame = CGRectMake(66, 240, 210, 30);
    [loginbtn setBackgroundColor:[UIColor cyanColor]];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:loginbtn];
    [loginbtn addTarget:self action:@selector(loginbtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loginbtn {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.u_mobile.text forKey:@"u_mobile"];
    [dict setValue:self.u_password.text forKey:@"u_password"];
    
    myVC *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"myVC"];
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];//单例方法
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSString *urlPath = [NSString stringWithFormat:@"http://localhost:8888/igo/users.php?action=login"];
    [mgr POST: urlPath parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         NSDictionary *dataDict = (NSDictionary *)responseObject;
         
         int code = [[dataDict valueForKey:@"code"]integerValue];
         if (code == 200) {
             NSArray *dataArr = [dataDict valueForKey:@"data"];
             NSDictionary *data = [dataArr firstObject];
             mvc.u_id = [[data valueForKey:@"u_id"]integerValue];
             
             /**
              *  消除返回按钮
              */
             mvc.navigationItem.hidesBackButton = YES;
             [self.navigationController pushViewController:mvc animated:YES];
         }
         
         
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
