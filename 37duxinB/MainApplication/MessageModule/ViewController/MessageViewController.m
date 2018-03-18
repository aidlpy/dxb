//
//  MessageViewController.m
//  37duxinB
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MessageViewController.h"
#import "ChatWithPaymentVC.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
}
@end

@implementation MessageViewController

void fetchEMFriends(MessageViewController *weakSelf){
    
    HttpsManager *httpsManager = [HttpsManager new];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [httpsManager getServerAPI:FetchEMFriends deliveryDic:dic successful:^(id responseObject) {
        NSLog(@"responseObject==>%@",responseObject);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([[dic objectForKey:@"code"] integerValue] ==200)
            {
                NSArray *dicArray = [[dic objectForKey:@"data"] objectForKey:@"data"];
                NSArray *array = [EMFriendModel fetchFriendArray:dicArray];
                [weakSelf->_dataArray removeAllObjects];
                [weakSelf->_dataArray addObjectsFromArray:array];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf->_tableView reloadData];
                    [weakSelf->_tableView.mj_header endRefreshing];
                });
            }
            else
            {
                [weakSelf errorWanring];
            }
            
        });
    } fail:^(id error) {
        [weakSelf errorWanring];
    }];
}

-(void)messagesDidReceive:(NSArray *)aMessages{
    fetchEMFriends(self);
    
}

-(void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
    fetchEMFriends(self);
}

-(void)errorWanring{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"获取环信好友失败" time:0.8];
        [_tableView.mj_header endRefreshing];
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}


-(void)initData{
    
    _dataArray =[[NSMutableArray alloc] init];
    [_tableView.mj_header beginRefreshing];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    fetchEMFriends(self);
}


-(void)initUI{
  
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView.middleBtn setTitle:@"消息" forState:UIControlStateNormal];
    [self.navView.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView.middleBtn.titleLabel setFont:FONT_20];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width,SIZE.height-h(self.navView))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        fetchEMFriends(self);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self customView];
    [_tableView.mj_header beginRefreshing];
    
}

-(void)customView{
    
    //初始化一个emptyView
    LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:Image(@"nonData")
                                                             titleStr:@"无数据"
                                                            detailStr:@""
                                                          btnTitleStr:@""
                                                        btnClickBlock:^{}];
    //元素竖直方向的间距
    emptyView.contentViewY = 70.0f;
    emptyView.titleLabTextColor = Color_BABABA;
    emptyView.titleLabFont = FONT_13;
    //设置空内容占位图
    _tableView.ly_emptyView = emptyView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    CustomerServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[CustomerServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]
        ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    EMFriendModel *model = _dataArray[indexPath.row];
    [cell updateUIModel:model];
    return cell;
}

-(void)author:(NSString *)cid fetchResult:(void(^)(BOOL result))resultBlock{
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic  = [[NSMutableDictionary alloc] init];
    [dic setObject:cid forKey:@"cid"];
    [httpsManager postServerAPI:FetchEMFriendsRelation deliveryDic:dic successful:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] ==200) {
            NSDictionary *dataDic = [dic objectForKey:@"data"];
            if ([[dataDic objectForKey:@"error_code"] integerValue] ==0) {
                NSDictionary *resultDic = [dataDic objectForKey:@"data"];
                NSNumber *status = [resultDic objectForKey:@"status"];
                
                if (status) {
                    BOOL isAutor = [status boolValue];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        resultBlock(isAutor);
                    });
                }
                else
                {
                    [self errorWanringOfRelation];
                    return;
                }
            }
        }
        else
        {
            [self errorWanringOfRelation];
            return;
        }
        
    } fail:^(id error) {
        [self errorWanringOfRelation];
        return;
    }];
}

-(void)errorWanringOfRelation{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"获取环信好友失败" time:0.8];
        [_tableView.mj_header endRefreshing];
    });
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     EMFriendModel *model = _dataArray[indexPath.row];
    if ( indexPath.row == 0)
    {
        CacheChatReceiverAdvatar(model.emFriendsAvatar);
        ChatWithPaymentVC *vc = [[ChatWithPaymentVC alloc] initWithConversationChatter:model.emFriendsChatUserName conversationType:EMConversationTypeChat];
        vc.hidesBottomBarWhenPushed = YES;
        vc.friendNickName = model.emFriendsNickname;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
       
        [SVProgressHUD show];
        [self author:model.emFriendID fetchResult:^(BOOL result) {
            if (result) {
                [SVProgressHUD dismiss];
                
                CacheChatReceiverAdvatar(model.emFriendsAvatar);
                ChatWithPaymentVC *vc = [[ChatWithPaymentVC alloc] initWithConversationChatter:model.emFriendsChatUserName conversationType:EMConversationTypeChat];
                vc.hidesBottomBarWhenPushed = YES;
                vc.friendNickName = model.emFriendsNickname;
                vc.hidesBottomBarWhenPushed = YES;
                if (vc) {
                    [SVProgressHUD dismiss];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [SVProgressHUD dismiss];
                    [SVHUD showErrorWithDelay:@"该用户未注册" time:0.8];
                }
                
            }
            else{
                
                [SVHUD showErrorWithDelay:@"关系不存在" time:0.8];
                
            }
        }];
    }
}

-(void)dealloc{
    
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
