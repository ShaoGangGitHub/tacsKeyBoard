//
//  TacsKeyBoardButton.h
//  YXGovermentSDK
//
//  Created by shg on 2019/10/2.
//  Copyright © 2019 yx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TacsKeyBoardButtonType) {
    TacsKeyBoardButtonType_normal,
    TacsKeyBoardButtonType_clear,
    TacsKeyBoardButtonType_down,
    TacsKeyBoardButtonType_sepec,
    TacsKeyBoardButtonType_shift,
    TacsKeyBoardButtonType_clear_other,
    TacsKeyBoardButtonType_down_other,
    TacsKeyBoardButtonType_sepec_other,
    TacsKeyBoardButtonType_shift_other,
    TacsKeyBoardButtonType_123,
    TacsKeyBoardButtonType_abc,
    TacsKeyBoardButtonType_fuhao,
};

@interface TacsKeyBoardButton : UIButton

@property (nonatomic,assign) TacsKeyBoardButtonType type;

@end

NS_ASSUME_NONNULL_END
