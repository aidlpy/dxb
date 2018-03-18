//
//  ReservationOrderModel.h
//  37duxinB
//
//  Created by Zhang Xinrong on 13/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseOrderModel.h"

@interface ReservationOrderModel : BaseOrderModel
@property(nonatomic,copy)NSString *orderUID;
@property(nonatomic,copy)NSString *orderCID;
@property(nonatomic,copy)NSString *orderConsultationStatus;
@property(nonatomic,copy)NSString *orderReservationID;
@property(nonatomic,copy)NSString *orderCSID;
@property(nonatomic,copy)NSString *orderOldPrice;
@property(nonatomic,copy)NSString *orderType;
@property(nonatomic,copy)NSString *orderStatus;
@property(nonatomic,assign)BOOL isReservation;
@property(nonatomic,assign)BOOL isInitiative;
@property(nonatomic,copy)NSString *orderCustomerDesc;
@property(nonatomic,copy)NSArray *packageTags;
@property(nonatomic,copy)NSArray *packageConsultationWay;
+(void)fetchArray:(NSArray *)array model:(void(^)(BOOL stop,ReservationOrderModel *model))fetchModelBlock;
@end
