//
//  MainVC.m
//  ZLQQ
//
//  Created by 10fenkeMacTwo on 16/7/20.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "MainVC.h"
#import "ZLFriendListVC.h"
@interface MainVC ()<EMUserListViewControllerDataSource>

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nameT.text = @"12345";
    _pswt.text = @"123456";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginClick:(id)sender {
    [[ZLHuanXinModel getInstance] loginUserName:_nameT.text psw:_pswt.text FinishSynBlock:^(EMError *error) {
        if (error) {//失败
            NSLog(@"%@",error.errorDescription);
        }
        else
        {
            [self loginOK];
        }
        
        
    }];
}
- (IBAction)registerClick:(id)sender {
    [[ZLHuanXinModel getInstance] registerHXWithUserName:_nameT.text psw:_pswt.text synFinishBlock:^(EMError *error)
    {
        if (error) {//失败
            NSLog(@"%@",error.errorDescription);
        }
        else
        {
            //成功
            
        }
        
    }];
}

- (void)loginOK
{
    
    EaseUsersListViewController *vc = [[EaseUsersListViewController alloc]init];
    vc.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

//联系人列表扩展样例
- (id<IUserModel>)userListViewController:(EaseUsersListViewController *)userListViewController
                           modelForBuddy:(NSString *)buddy
{
    //用户可以根据自己的用户体系，根据buddy设置用户昵称和头像
    id<IUserModel> model = nil;
    model = [[EaseUserModel alloc] initWithBuddy:buddy];
//    model.avatarURLPath = @"";//头像网络地址
    model.nickname = @"昵称";//用户昵称
    return model;
}


@end
