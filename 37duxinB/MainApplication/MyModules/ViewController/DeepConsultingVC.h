//
//  DeepConsultingVC.h
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseViewController.h"
#import "PackageModel.h"

@interface DeepConsultingVC : BaseViewController
@property(nonatomic,assign)BOOL isEdit;
-(void)setmodel:(PackageModel *)model;
@end
