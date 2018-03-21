//
//  CardInfoViewController.m
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CardInfoViewController.h"
#import "SelectedPhotosCell.h"
#import "TextFieldCell.h"
#import "SelectedSinglePhotoCell.h"
#import "BackgroundViewController.h"
#import "LocationPhotoModel.h"


@interface CardInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate>
{
    UITableView *_tableView;
    NSArray *_titleArray;
    NSMutableArray *_infoArray;
    LocationPhotoModel *_locationPhoto;
    
}
@end

@implementation CardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];

}

-(void)initData{

    _titleArray =
    @[@{@"title":@"证件类型",@"required":@"1",@"palceHolder":@"请选择",@"editable":@"0",@"arrowState":@"1"},
      @{@"title":@"证件号",@"required":@"1",@"palceHolder":@"请输入证件号",@"editable":@"1",@"arrowState":@"1"},
      @{@"title":@"证件照片",@"required":@"0",@"palceHolder":@"",@"editable":@"0"},
      @{@"title":@"学历",@"required":@"0",@"palceHolder":@"请选择",@"editable":@"0",@"arrowState":@"1"},
      @{@"title":@"学历证书",@"required":@"0",@"palceHolder":@"",@"editable":@"1"}];
    
     NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"" forKey:@"leftImage"];
    [dic setObject:@"" forKey:@"rightImage"];
    _infoArray = [[NSMutableArray alloc] initWithObjects:@"",@"",dic,@"",@"", nil];
    
    _locationPhoto = [LocationPhotoModel new];
    
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 ||indexPath.row == 4) {
        return 75.0f;
    }else{
       return 53.0f;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic =_titleArray[indexPath.row];
    if (indexPath.row ==2 )
    {
        
        static NSString *SelectedPhotosCellID = @"selectedPhotosCellID";
        SelectedPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectedPhotosCellID];
        if (cell == nil) {
            cell = [[SelectedPhotosCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectedPhotosCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        cell.photoSelectionBlock = ^(BOOL isLeft, NSInteger tag) {
            _locationPhoto.row = tag;
            _locationPhoto.isLeft = isLeft;
            [self showActionSheet];
        };
        NSDictionary *imageDic = _infoArray[indexPath.row];
        [cell updateUI:dic];
        if (![[imageDic objectForKey:@"leftImage"] isEqualToString:@""])
        {
            [cell.leftBtn sd_setImageWithURL:[NSURL URLWithString:[imageDic objectForKey:@"leftImage"]] forState:UIControlStateNormal];
        }
     
        if (![[imageDic objectForKey:@"rightImage"] isEqualToString:@""])
        {
            [cell.rightBtn sd_setImageWithURL:[NSURL URLWithString:[imageDic objectForKey:@"rightImage"]] forState:UIControlStateNormal];
        }
        return cell;

    }
    else
    if (indexPath.row == 4)
    {
        static NSString *SelectedSinglePhotoCellID = @"selectedSinglePhotoCellID";
        SelectedSinglePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectedSinglePhotoCellID];
        if (cell == nil) {
            cell = [[SelectedSinglePhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectedSinglePhotoCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        cell.photoSelectionBlock = ^(BOOL isLeft, NSInteger tag) {
            _locationPhoto.row = tag;
            _locationPhoto.isLeft = isLeft;
            [self showActionSheet];
        };
        [cell updateUI:dic];
        if (![[_infoArray objectAtIndex:4] isEqualToString:@""]) {
            [cell.leftBtn sd_setImageWithURL:[NSURL URLWithString:[_infoArray objectAtIndex:4]] forState:UIControlStateNormal];
        }
        return cell;
    }
    else
    {
        
        static NSString *textFieldCellID = @"textFieldCellID";
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellID];
        if (cell == nil) {
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        cell.textFieldBlock = ^(UITextField *textField) {
            if (indexPath.row == 1) {
                [_infoArray replaceObjectAtIndex:1 withObject:textField.text];
            }
        };
        if (![_infoArray[indexPath.row] isEqualToString:@""]) {
            if (indexPath.row == 0) {
                if ([_infoArray[indexPath.row] isEqualToString:@"0"]) {
                    cell.textFild.text = @"大陆身份证";
                }
                else if([_infoArray[indexPath.row] isEqualToString:@"1"])
                {
                     cell.textFild.text = @"台胞证";
                }
                else{
                    cell.textFild.text = @"护照";
                    
                }
            }
            else
            if (indexPath.row ==3) {
                if ([_infoArray[indexPath.row] isEqualToString:@"0"]) {
                    cell.textFild.text = @"小学";
                }
                else if([_infoArray[indexPath.row] isEqualToString:@"1"])
                {
                    cell.textFild.text = @"初中";
                }
                else if([_infoArray[indexPath.row] isEqualToString:@"2"])
                {
                    cell.textFild.text = @"高中";
                }
                else if([_infoArray[indexPath.row] isEqualToString:@"3"])
                {
                    cell.textFild.text = @"大专";
                }
                else if([_infoArray[indexPath.row] isEqualToString:@"4"])
                {
                    cell.textFild.text = @"本科";
                }
                else if([_infoArray[indexPath.row] isEqualToString:@"5"])
                {
                    cell.textFild.text = @"硕士";
                }
                else{
                    cell.textFild.text = @"博士及博士以上";
                }
            }
            else
            {
                cell.textFild.text = _infoArray[indexPath.row];
            }
           
        }
        [cell updateUI:dic];
        return cell;
        
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self showCardTypeAction];
        }
            break;
        case 3:
        {
            [self showEducationLevelAction];
        }
            break;
   
            
        default:
            break;
    }
    
    
}

-(void)showCardTypeAction{
    
    UIAlertController *AlertSelect = [UIAlertController new];
    UIAlertAction *mainlandAction = [UIAlertAction actionWithTitle:@"大陆身份证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:0 withObject:@"0"];
        [_tableView reloadData];
    }];
    UIAlertAction *taiwanAction = [UIAlertAction actionWithTitle:@"台胞证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:0 withObject:@"1"];
        [_tableView reloadData];
    }];
    UIAlertAction *passportAction = [UIAlertAction actionWithTitle:@"护照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [_infoArray replaceObjectAtIndex:0 withObject:@"2"];
        [_tableView reloadData];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [AlertSelect addAction:mainlandAction];
    [AlertSelect addAction:taiwanAction];
    [AlertSelect addAction:passportAction];
    [AlertSelect addAction:cancelAction];
    [self presentViewController:AlertSelect animated:YES completion:nil];
}

-(void)showEducationLevelAction{
    
    UIAlertController *AlertSelect = [UIAlertController new];
    UIAlertAction *primaraySchoolAction = [UIAlertAction actionWithTitle:@"小学" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:3 withObject:@"0"];
        [_tableView reloadData];
    }];
    UIAlertAction *generalSchoolAction = [UIAlertAction actionWithTitle:@"初中" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:3 withObject:@"1"];
        [_tableView reloadData];
    }];
    UIAlertAction *hightSchool = [UIAlertAction actionWithTitle:@"高中" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:3 withObject:@"2"];
        [_tableView reloadData];
    }];
    UIAlertAction *diplomaSchoolAction = [UIAlertAction actionWithTitle:@"大专" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:3 withObject:@"3"];
        [_tableView reloadData];
    }];
    UIAlertAction *bachoreSchoolAction = [UIAlertAction actionWithTitle:@"本科" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:3 withObject:@"4"];
        [_tableView reloadData];
    }];
    
    UIAlertAction *masterAction = [UIAlertAction actionWithTitle:@"硕士" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:3 withObject:@"5"];
        [_tableView reloadData];
    }];
    
    UIAlertAction *doctorAction = [UIAlertAction actionWithTitle:@"博士及以上" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray replaceObjectAtIndex:3 withObject:@"6"];
        [_tableView reloadData];
    }];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [AlertSelect addAction:primaraySchoolAction];
    [AlertSelect addAction:generalSchoolAction];
    [AlertSelect addAction:hightSchool];
    [AlertSelect addAction:diplomaSchoolAction];
    [AlertSelect addAction:bachoreSchoolAction];
    [AlertSelect addAction:masterAction];
    [AlertSelect addAction:doctorAction];
    [AlertSelect addAction:cancelAction];
    [self presentViewController:AlertSelect animated:YES completion:nil];
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

-(UIView  *)fetchImageView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,85)];
    view.backgroundColor = Color_F1F1F1;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 80)];
    imageView.backgroundColor = [UIColor whiteColor];
    [imageView setImage:[UIImage imageNamed:Image(@"step_1")]];
    [view addSubview:imageView];
    
    
    return  view;
    
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
                if (_locationPhoto.row == 2) {
                    NSMutableDictionary *dic = _infoArray[2];
                    if (_locationPhoto.isLeft) {
                        [dic setObject:currentString forKey:@"leftImage"];
                    }
                    else
                    {
                        [dic setObject:currentString forKey:@"rightImage"];
                    }
                }
                else{
                    
                    [_infoArray replaceObjectAtIndex:4 withObject:currentString];
                    
                }
                
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

-(void)nextStepAction:(UIButton *)sender{
    
    
    __block BOOL isOkay = YES;
    
    [_infoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0 || idx ==1) {
            
      
        NSString *string = (NSString *)obj;
        
        if ([obj isKindOfClass:[NSString class]] && [string isEqualToString:@""]) {
            
            NSString *string = [_titleArray[idx] objectForKey:@"title"];
            [SVHUD  showErrorWithDelay:[NSString stringWithFormat:@"请输入%@",string]time:0.8f];
            isOkay = NO;
            if(!isOkay){
                *stop = YES;
            }
            
        }
        else
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)obj;
                if([[dic objectForKey:@"leftImage"] isEqualToString:@""] && [[dic objectForKey:@"rightImage"] isEqualToString:@""]){
                    
                    NSString *string = [_titleArray[idx] objectForKey:@"title"];
                    [SVHUD  showErrorWithDelay:[NSString stringWithFormat:@"请输入%@",string]time:0.8f];
                    isOkay = NO;
                    if(!isOkay){
                        *stop = YES;
                    }
                }
            }
        }
    }];
    
    if (isOkay) {
        [SVProgressHUD show];
        HttpsManager *httpsManager = [HttpsManager new];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:_usernameString forKey:@"username"];
        [dic setObject:_infoArray[0] forKey:@"passport_type"];
        [dic setObject:_infoArray[1] forKey:@"passport_no"];
        NSMutableDictionary *cardDic = _infoArray[2];
        [dic setObject:[cardDic objectForKey:@"leftImage"] forKey:@"passport_positive"];
        [dic setObject:[cardDic objectForKey:@"rightImage"] forKey:@"passport_opposite"];
        [dic setObject:_infoArray[3] forKey:@"education_type"];
        [dic setObject:_infoArray[4] forKey:@"education_cert"];

        [httpsManager postServerAPI:PostBCardInfo deliveryDic:dic successful:^(id responseObject) {
            [SVProgressHUD dismiss];
            if ([[responseObject objectForKey:@"code"] integerValue] ==200) {
                NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                if ([[dataDic objectForKey:@"error_code"] integerValue] == 0) {
                    [SVHUD showSuccessWithDelay:@"身份信息提交成功！" time:0.8f blockAction:^{
                        BackgroundViewController *vc = [BackgroundViewController new];
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
