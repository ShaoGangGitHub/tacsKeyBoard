//
//  TacsKeyBoard.h
//  YXGovermentSDK
//
//  Created by shg on 2019/9/30.
//  Copyright © 2019 yx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TacsKeyBoardButton.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TacsKeyBoardType) {
    TacsKeyBoardType_Number,
    TacsKeyBoardType_IDCard,
    TacsKeyBoardType_Normal,
    TacsKeyBoardType_Normal_Other,
    TacsKeyBoardType_PassWord,
};

@protocol TacsInputAccessoryViewDelegate <NSObject>

- (void)choseKeyBoardWithIndex:(NSInteger)index;
- (void)tapActionPassWord:(TacsKeyBoardButton *)sender;

@end
@class TacsInputView;
@class TacsInputAccessoryView;
@interface TacsKeyBoard : NSObject<TacsInputAccessoryViewDelegate>

@property (nonatomic,strong) TacsInputAccessoryView *inputAccessoryView;
@property (nonatomic,strong) TacsInputView *inputView;
@property (nonatomic,copy)   UITextField * (^setTextffiled)(TacsKeyBoardButton *button);
@property (nonatomic,assign) TacsKeyBoardType keyBaordType;

@end

@interface TacsInputView : UIView

- (void)changeIndex:(NSInteger)index;
@property (nonatomic,copy) UITextField * (^setTextffiled)(TacsKeyBoardButton *button);
@property (nonatomic,assign) TacsKeyBoardType keyBaordType;
- (void)tapPassWordKeyBoard:(TacsKeyBoardButton *)sender;

@end

@interface TacsInputAccessoryView : UIView

@property (nonatomic,weak) id<TacsInputAccessoryViewDelegate>delegate;
@property (nonatomic,assign) TacsKeyBoardType keyBaordType;

@end

NS_ASSUME_NONNULL_END
