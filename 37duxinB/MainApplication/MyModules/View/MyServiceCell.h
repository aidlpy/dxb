//
//  MyServiceCell.h
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackageModel.h"

@interface MyServiceCell : UITableViewCell
@property(nonatomic,retain)UIView *baseView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *tagLabel;
@property(nonatomic,retain)UILabel *commuicateLabel;
@property(nonatomic,retain)UILabel *serviceTimeLabel;
@property(nonatomic,retain)UILabel *serviceSinglePriceLabel;
@property(nonatomic,retain)UILabel *serviceDetailLabel;
@property(nonatomic,retain)UILabel *serviceCreateTimeLabel;

-(void)updateUI:(PackageModel *)model;

@end
