//
//  PackageModel.h
//  37duxinB
//
//  Created by Zhang Xinrong on 19/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageModel : NSObject
@property(nonatomic,copy)NSString *packageId;
@property(nonatomic,copy)NSString *packageTitle;
@property(nonatomic,copy)NSString *packageConsultationWay;
@property(nonatomic,copy)NSString *packageServiceType;
@property(nonatomic,copy)NSString *packageServiceTimes;
@property(nonatomic,copy)NSString *packageServiceHours;
@property(nonatomic,copy)NSString *packageServiceSinglePrice;
@property(nonatomic,copy)NSString *packageServiceContent;
@property(nonatomic,copy)NSString *packageServiceTags;
@property(nonatomic,copy)NSString *packageServiceCreateTime;
@property(nonatomic,assign)CGFloat cellHeight;

+(void)fetchArray:(NSArray *)array model:(void(^)(BOOL stop,PackageModel *model))fetchModelBlock;

@end
