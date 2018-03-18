//
//  WithdrawRecordModel.m
//  37duxinB
//
//  Created by Zhang Xinrong on 23/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "WithdrawRecordModel.h"

@implementation WithdrawRecordModel
+(void)fetchArray:(NSArray *)array fetchModel:(void(^)(BOOL isStop,WithdrawRecordModel *model))fetchModelBlock{
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        WithdrawRecordModel *newModel = [WithdrawRecordModel new];
        newModel.withDrawMoney = [dic objectForKey:@"actual"];
        newModel.withDrawApplyStatus = [dic objectForKey:@"apply_status"];
        NSNumber *number = [dic objectForKey:@"created_at"];
        newModel.withDrawDate = [number.stringValue timeWithTimeIntervalStringWithFullData];
        NSLog(@"withDrawDate==>%@",newModel.withDrawDate);
        fetchModelBlock(stop,newModel);
    }];
}


@end
