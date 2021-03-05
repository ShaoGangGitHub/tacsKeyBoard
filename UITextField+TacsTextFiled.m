//
//  UITextField+TacsTextFiled.m
//  YXGovermentSDK
//
//  Created by shg on 2019/10/4.
//  Copyright © 2019 yx. All rights reserved.
//

#import "UITextField+TacsTextFiled.h"
#import <objc/runtime.h>
static NSString *objKey = @"objKeyType";
static NSString *objKeyboard = @"objKeyboard";
static NSString *objKeyboardType = @"objKeyboardType";
@implementation UITextField (TacsTextFiled)

@dynamic type;
@dynamic keyboard;
@dynamic keyBoardType;
@dynamic selectedRange;
- (void)setType:(TacsTextFiledType)type
{
    objc_setAssociatedObject(self, &objKey, @(type), OBJC_ASSOCIATION_ASSIGN);
    if (type==TacsTextFiledType_password) {
        self.inputAccessoryView = self.keyboard.inputAccessoryView;
        self.inputView = self.keyboard.inputView;
    }
}

- (TacsTextFiledType)type
{
    NSNumber *number = objc_getAssociatedObject(self, &objKey);
    return [number integerValue];
}

- (TacsKeyBoard *)keyboard
{
    TacsKeyBoard *kb = objc_getAssociatedObject(self, &objKeyboard);
    if (!kb) {
        kb = [[TacsKeyBoard alloc] init];
        objc_setAssociatedObject(self, &objKeyboard, kb, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        __weak typeof(self) weakSelf = self;
        kb.setTextffiled = ^UITextField * _Nonnull(TacsKeyBoardButton * _Nonnull button) {
            return weakSelf;
        };
    }
    return kb;
}

- (void)setKeyBoardType:(TacsKeyBoardType)keyBoardType
{
    objc_setAssociatedObject(self, &objKeyboardType, @(keyBoardType), OBJC_ASSOCIATION_ASSIGN);
    self.keyboard.keyBaordType = keyBoardType;
    self.inputAccessoryView = self.keyboard.inputAccessoryView;
    self.inputView = self.keyboard.inputView;
}

- (TacsKeyBoardType)keyBoardType
{
    NSNumber *number = objc_getAssociatedObject(self, &objKeyboardType);
    return [number integerValue];
}

- (NSRange)selectedRange
{
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    NSInteger length = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];
    return NSMakeRange(location, length);
}

- (void)setSelectedRange:(NSRange)selectedRange
{
    UITextPosition *startPosition = [self positionFromPosition:self.beginningOfDocument offset:selectedRange.location];
    UITextPosition *endPosition = [self positionFromPosition:self.beginningOfDocument offset:selectedRange.location + selectedRange.length];
    UITextRange *selectedTextRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectedTextRange];
}

@end
