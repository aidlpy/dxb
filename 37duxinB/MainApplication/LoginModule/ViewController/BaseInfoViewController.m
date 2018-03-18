//
//  BaseInfoViewController.m
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseInfoViewController.h"
#import "CardInfoViewController.h"
#import "SelectedImageCell.h"
#import "TextFieldCell.h"
#import "CBImageCompressor.h"
#import "SelectingAreaView.h"


@interface BaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate>
{
    UITableView *_tableView;
    NSArray *_titleArray;
    NSMutableArray *_infoArray;

    
}
@end

@implementation BaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    _infoArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",_usernameString,@"",@"",nil];
    _titleArray =
    @[@{@"title":@"头像",@"required":@"1",@"palceHolder":@"",@"arrowState":@"0"},
  @{@"title":@"姓名",@"required":@"1",@"palceHolder":@"请输入真实姓名",@"editable":@"1",@"arrowState":@"1"},
  @{@"title":@"性别",@"required":@"1",@"palceHolder":@"请选择",@"editable":@"0",@"arrowState":@"1"},
  @{@"title":@"手机号",@"required":@"1",@"palceHolder":@"",@"editable":@"0",@"arrowState":@"1"},
  @{@"title":@"微信号",@"required":@"1",@"palceHolder":@"请输入微信号",@"editable":@"1",@"arrowState":@"1"},
  @{@"title":@"所在地",@"required":@"1",@"palceHolder":@"请选择",@"editable":@"0",@"arrowState":@"0"}];
    
}

-(void)initUI{

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"申请入驻" rightImage:@"whiteLeftArrow"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width, SIZE.height-h(self.navView))];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.tableHeaderView = [self fetchImageView];
    _tableView.tableFooterView = [self fetchFooter];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(UIView  *)fetchImageView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,85)];
    view.backgroundColor = Color_F1F1F1;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 80)];
    imageView.backgroundColor = [UIColor whiteColor];
    [imageView setImage:[UIImage imageNamed:Image(@"step0")]];
    [view addSubview:imageView];
    
    
    return  view;
    
}

-(UIView *)fetchFooter{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 170)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextStepBtn = [[UIButton alloc] initWithFrame:CGRectMake(35,48,SIZE.width-70,40)];
    nextStepBtn.backgroundColor = Color_5ECAF5;
    [nextStepBtn.layer setCornerRadius:2.0f];
    [nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepBtn addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:nextStepBtn];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(35,bottom(nextStepBtn)+20,SIZE.width-70,40)];
    backBtn.backgroundColor = Color_5ECAF5;
    [backBtn.layer setCornerRadius:2.0f];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    
    return view;
}

-(void)nextStepAction:(UIButton *)sender{
    
    
    __block BOOL isOkay = YES;
    
    [_infoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *string = (NSString *)obj;
        
        if ([string isEqualToString:@""]) {
            
            NSString *string = [_titleArray[idx] objectForKey:@"title"];
            [SVHUD  showErrorWithDelay:[NSString stringWithFormat:@"请输入%@",string]time:0.8f];
            isOkay = NO;
            if(!isOkay){
                *stop = YES;
            }
            
        }
        
    }];

    if (isOkay) {
        [SVProgressHUD show];
        HttpsManager *httpsManager = [HttpsManager new];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:_infoArray[0] forKey:@"avatar"];
        [dic setObject:_infoArray[1] forKey:@"name"];
        [dic setObject:_infoArray[2] forKey:@"gender"];
        [dic setObject:_infoArray[3] forKey:@"username"];
        [dic setObject:_infoArray[4] forKey:@"wechat"];
        [dic setObject:_infoArray[5] forKey:@"area"];
        [httpsManager postServerAPI:PostBSingleBase deliveryDic:dic successful:^(id responseObject) {
            [SVProgressHUD dismiss];
            if ([[responseObject objectForKey:@"code"] integerValue] ==200) {
                NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
                    [SVHUD showSuccessWithDelay:@"基本信息提交成功！" time:0.8f blockAction:^{
                        CardInfoViewController *vc = [CardInfoViewController new];
                        vc.usernameString = [dataDic objectForKey:@"username"];
                        [self.navigationController  pushViewController:vc animated:YES];
                    }];
                }
            }
        } fail:^(id error) {
            [SVHUD showErrorWithDelay:@"网络请求失败" time:0.8];
        }];
    }

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 53.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic =_titleArray[indexPath.row];
    if (indexPath.row ==0) {
        static NSString *selectedImageCell = @"selectedImageCell";
        SelectedImageCell *cell = [tableView dequeueReusableCellWithIdentifier:selectedImageCell];
        if (cell == nil) {
            cell = [[SelectedImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectedImageCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        if ([_infoArray objectAtIndex:0] != nil) {
            [cell.imageBtn sd_setImageWithURL:[NSURL URLWithString:_infoArray[0]] forState:UIControlStateNormal];
            [[SDImageCache sharedImageCache] clearMemory];
        }
        cell.selectImageBlock = ^(UIButton *sender) {
            [self selectImageBlock:sender];
        };
        [cell updateUI:dic];
        return cell;
    }
    else{
        
        static NSString *textFieldCellID = @"textFieldCell";
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellID];
        if (cell == nil) {
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        cell.textFieldBlock = ^(UITextField *textField) {
            NSLog(@"textField.tag==>%ld",textField.tag);
            [_infoArray replaceObjectAtIndex:textField.tag withObject:textField.text];
        };
        [cell updateUI:dic];
        if (![[_infoArray objectAtIndex:indexPath.row] isEqualToString:@""]) {
            if (indexPath.row == 2) {
                cell.textFild.text = [_infoArray[indexPath.row] isEqualToString:@"1"]?@"男":@"女";
            }
            else
            {
                cell.textFild.text = _infoArray[indexPath.row];
            }
           
        }
        return cell;
        
    }

}

-(void)selectImageBlock:(UIButton *)sender{
    
    [self showActionSheet];
    
    
}

-(void)showActionSheet
{
    UIAlertController *AlertSelect = [UIAlertController new];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self localPhoto];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [AlertSelect addAction:camera];
    [AlertSelect addAction:photo];
    [AlertSelect addAction:cancelAction];
    
    [self presentViewController:AlertSelect animated:YES completion:nil];
    
}

-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        
    {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:NO completion:nil];
        
    }
    else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


-(void)localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //先把图片转成NSData
           UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
           NSData *yadata =UIImageJPEGRepresentation(image,0.6f);
            [self postPhoto:yadata];
        });
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)postPhoto:(NSData *)data{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"type"];
    [httpsManager postServerAPI:postImageURL Paramater:dic data:data name:@"touxiang.jpg" andContentType:@"image/jpeg" successful:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] ==200) {

            NSDictionary *dataDic = [dic objectForKey:@"data"];
            
            if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
                
                NSString *url = [dataDic objectForKey:@"url"];
                NSMutableString *mutableString = [NSMutableString stringWithString:url];
                NSString *currentString = [mutableString stringByReplacingOccurrencesOfString:@"-internal" withString:@""];
                [_infoArray replaceObjectAtIndex:0 withObject:currentString];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }
            else{
                [self errorwarning];
            }
        }
        
    } fail:^(id error) {

        [self errorwarning];
    }];
}

-(void)errorwarning{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"选择照片失败" time:0.8];
    });
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self showActionSheet];
        }
            break;
        case 2:
        {
            [self showSexAction];
        }
            break;
        case 5:
        {
            [self showAreaPlace];
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void)showSexAction{
    
    UIAlertController *AlertSelect = [UIAlertController new];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:2 withObject:@"1"];
        [_tableView reloadData];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:2 withObject:@"2"];
        [_tableView reloadData];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [AlertSelect addAction:camera];
    [AlertSelect addAction:photo];
    [AlertSelect addAction:cancelAction];
    [self presentViewController:AlertSelect animated:YES completion:nil];
}

-(void)showAreaPlace{
    
    SelectingAreaView *view = [[SelectingAreaView alloc] initWithFrame:CGRectMake(0,SIZE.height-SIZE.height/4, SIZE.width, SIZE.height/4)];
    view.fetchAreaBlock = ^(NSString *string) {
        [_infoArray replaceObjectAtIndex:5 withObject:string];
        [_tableView reloadData];
    };
    [self.view addSubview:view];

}


-(void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
