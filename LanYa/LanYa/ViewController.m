//
//  ViewController.m
//  LanYa
//
//  Created by 10fenkeMacTwo on 16/7/22.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "ZLLanYaManage.h"
@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CBCentralManager *manager;

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (strong,nonatomic) CBService* a2A0server;



@property (strong,nonatomic) NSMutableArray *peripheralArray;

@property (weak, nonatomic) IBOutlet UITableView *bluetoothTable;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@property (strong,nonatomic) CBCharacteristic *writeCh;
@property (strong,nonatomic) CBCharacteristic *writeDescCh;

@property (strong,nonatomic) CBDescriptor *descp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化并设置委托和线程队列，最好一个线程的参数可以为nil，默认会就main线程
    _peripheralArray = [NSMutableArray array];
    _bluetoothTable.delegate = self;
    _bluetoothTable.dataSource = self;
    [_bluetoothTable registerNib:[UINib nibWithNibName:@"ZLCell" bundle:nil] forCellReuseIdentifier:@"ZLCell"];
    
    [ZLLanYaManage scanPeripheralDiscoveryBlock:^ (CBCentralManager *central, CBPeripheral *peripheral, NSDictionary<NSString *,id> *advertisementData, NSNumber *RSSI)
     {
         // NSLog(@"当扫描到设备:%@",peripheral);
         if ( [_peripheralArray containsObject:peripheral]) {
             return;
         }else
         {
             [_peripheralArray addObject:peripheral];
             [_bluetoothTable reloadData];
         }
     }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify:) name:ZLNotiCharactChange object:nil];
}
- (void)notify:(NSNotification *)userInfo
{
    if ([userInfo.object isKindOfClass:[CBCharacteristic class]])
    {
        CBCharacteristic *ch = userInfo.object;
        NSLog(@"%@",ch.value);
    }
    if ([userInfo.object isKindOfClass:[NSNumber class]])
    {
        NSNumber *number = userInfo.object;
        ZLSK sk = number.integerValue;
        NSLog(@"%ld",(long)sk);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}







#pragma mark  -----


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    _resultTextView.text = @"";
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _peripheralArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLCell"];
    CBPeripheral *per = [_peripheralArray objectAtIndex:indexPath.row];
    cell.textV.text = per.description;
    
    _resultTextView.text = [_resultTextView.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",per.description]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPeripheral *per = [_peripheralArray objectAtIndex:indexPath.row];
    
    NSLog(@"尝试链接%@",per.description);
    
    [ZLLanYaManage connectPeripheral:per successBlock:^(CBPeripheral *peripheral) {
        NSLog(@"%@", [NSString stringWithFormat:@"成功连接 peripheral: %@ with UUID: %@",peripheral,peripheral.identifier]);
        
        _peripheral = peripheral;
        _perDelegate = [[ZLPeripheralDelegate alloc]initWithPeripheral:_peripheral];
        [_perDelegate discoveryAll];
        [ZLJianWeiTool writeChatcteristcPeripheral:_peripheral];
        
    } errorBlock:^(CBPeripheral *peri, NSError *error) {
        NSLog(@"链接外设%@",error);
    }];
    
    [tableView reloadData];
}






@end
