//
//  RegisterViewController.m
//  igo
//
//  Created by Destiny on 15/9/22.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "MyViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *u_mobile;
@property (weak, nonatomic) IBOutlet UITextField *u_password;
@property (weak, nonatomic) IBOutlet UITextField *en_password;
- (IBAction)btnRegister;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btnRegister {
    if([self.u_password.text isEqualToString:self.en_password.text]){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.u_mobile.text forKey:@"u_mobile"];
        [dict setValue:self.u_password.text forKey:@"u_password"];
        [manager POST:@"http://localhost:8888/igo/users.php?action=add" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            int code = [[dic valueForKey:@"code"]intValue];
            if(code == 200){
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MyViewController *myVC = [sb instantiateViewControllerWithIdentifier:@"userVC"];
                myVC.u_mobile = [dict[@"u_mobile"]integerValue];
                [self.navigationController pushViewController:myVC animated:YES];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alert show];
            }
        } failure:^(AFHTTPRequestOperation * operation, NSError *error ) {
            NSLog(@"错误%@",error);
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"输入的密码与确认密码不一致！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alert show];
    }
}
@end
