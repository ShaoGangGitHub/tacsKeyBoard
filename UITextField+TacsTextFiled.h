//
//  UITextField+TacsTextFiled.h
//  YXGovermentSDK
//
//  Created by shg on 2019/10/4.
//  Copyright © 2019 yx. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TacsKeyBoard.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, TacsTextFiledType) {
    TacsTextFiledType_normal   = 0,
    TacsTextFiledType_password = 1,
};
@interface UITextField (TacsTextFiled)

@property (nonatomic,assign) TacsTextFiledType type;
@property (nonatomic,strong) TacsKeyBoard *keyboard;
@property (nonatomic,assign) TacsKeyBoardType keyBoardType;
@property (nonatomic,assign) NSRange selectedRange;

@end

NS_ASSUME_NONNULL_END
