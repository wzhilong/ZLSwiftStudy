//
//  ZLFriendListVC.m
//  ZLQQ
//
//  Created by 10fenkeMacTwo on 16/7/21.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "ZLFriendListVC.h"
#import "EaseUI.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "ZLTool.h"
@interface ZLFriendListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray * dataArray;

@end

@implementation ZLFriendListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    self.title = @"通讯录";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self getUserData];
    
}
- (void)getUserData
{
    __weak ZLFriendListVC *wself = self;
    [SVProgressHUD show];
    [[EMClient sharedClient].contactManager asyncGetContactsFromServer:^(NSArray *aList) {
        [wself.dataArray addObjectsFromArray:aList];
        [wself.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(EMError *aError) {
        [SVProgressHUD  showErrorWithStatus:aError.errorDescription];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            
        }
        if (indexPath.row == 1) {
            
        }
        if (indexPath.row == 1) {
            
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FriendCell"];
    }
    EaseUserModel *model = [[EaseUserModel alloc]init];
    [model setValuesForKeysWithDictionary:_dataArray[indexPath.row]];
    
    cell.textLabel.text = model.nickname;
    cell.detailTextLabel.text = model.buddy;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatarURLPath]];
    
    return cell;
}


@end
