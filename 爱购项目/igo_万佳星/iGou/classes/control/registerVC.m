//
//  registerVC.m
//  iGou
//
//  Created by administrator on 9/24/15.
//  Copyright © 2015 xingxing. All rights reserved.
//

#import "registerVC.h"
#import "AFNetworking.h"
#import "loginVC.h"
@interface registerVC ()
@property (weak, nonatomic) IBOutlet UITextField *u_mobile;
@property (weak, nonatomic) IBOutlet UITextField *u_name;
@property (weak, nonatomic) IBOutlet UITextField *u_email;
@property (weak, nonatomic) IBOutlet UITextField *u_password;
@property (weak, nonatomic) IBOutlet UITextField *query;
@property (weak, nonatomic) IBOutlet UILabel *hint;

@end

@implementation registerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  设置提示文本框
     */
    [self.hint setTextColor:[UIColor redColor]];
    self.hint.font = [UIFont systemFontOfSize:12];
    
    UIButton *registerbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerbtn.layer.cornerRadius = 10;
    registerbtn.frame = CGRectMake(62, 354, 210, 30);
    [registerbtn setBackgroundColor:[UIColor cyanColor]];
    [registerbtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerbtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:registerbtn];
    [registerbtn addTarget:self action:@selector(registerbtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)registerbtn {
    if (self.u_password.text == self.query.text)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.u_mobile.text forKey:@"u_mobile"];
        [dict setValue:self.u_password.text forKey:@"u_password"];
        [dict setValue:self.u_email.text forKey:@"u_email"];
        [dict setValue:self.u_name.text forKey:@"u_name"];
        
        loginVC *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];//单例方法
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        
        NSString *urlPath = [NSString stringWithFormat:@"http://localhost:8888/igo/users.php?action=add"];
        [mgr POST: urlPath parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             NSDictionary *dataDict = (NSDictionary *)responseObject;
             //         NSLog(@"response--%@",responseObject);
             int code = [[dataDict valueForKey:@"code"]integerValue];
             if (code == 200) {
                 
                 [self.navigationController pushViewController:lvc animated:YES];
             }
         }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@",error);
         }];
    }
    else
    {
        self.hint.text = @"密码不一致";
        
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}











@end
