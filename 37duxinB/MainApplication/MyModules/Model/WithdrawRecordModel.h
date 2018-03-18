//
//  WithdrawRecordModel.h
//  37duxinB
//
//  Created by Zhang Xinrong on 23/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawRecordModel : NSObject
@property(nonatomic,copy)NSString *withDrawMoney;
@property(nonatomic,copy)NSString *withDrawDate;
@property(nonatomic,copy)NSString *withDrawApplyStatus;
+(void)fetchArray:(NSArray *)array fetchModel:(void(^)(BOOL isStop,WithdrawRecordModel *model))fetchModelBlock;
@end
