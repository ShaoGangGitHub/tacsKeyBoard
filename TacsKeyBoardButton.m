//
//  TacsKeyBoardButton.m
//  YXGovermentSDK
//
//  Created by shg on 2019/10/2.
//  Copyright © 2019 yx. All rights reserved.
//

#import "TacsKeyBoardButton.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation TacsKeyBoardButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"self.selected" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"self.selected"]) {
        if (self.type==TacsKeyBoardButtonType_shift_other) {
            [self setNeedsDisplay];
        }
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"self.selected"];
}

- (void)setType:(TacsKeyBoardButtonType)type
{
    _type = type;
    if (type==TacsKeyBoardButtonType_down) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitle:@"完成" forState:UIControlStateNormal];
    }
    if (type==TacsKeyBoardButtonType_normal) {
        [self setTitleColor:[UIColor lightColor:[UIColor darkTextColor] darkColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }
    if (type==TacsKeyBoardButtonType_clear) {
        [self setImage:[UIImage name:@"newdelete"] forState:UIControlStateNormal];
    }
    if (type==TacsKeyBoardButtonType_shift) {
        [self setImage:[UIImage name:@"newcapsLock"] forState:UIControlStateNormal];
        [self setImage:[UIImage name:@"shift"] forState:UIControlStateSelected];
    }
    if (type==TacsKeyBoardButtonType_sepec) {
        [self setTitle:@"安全键盘" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17 weight:1.05];
        [self setTitleColor:[UIColor lightColor:[UIColor darkTextColor] darkColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }
    if (type==TacsKeyBoardButtonType_shift_other) {
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self setTitle:@"↑" forState:UIControlStateNormal];
    }
    if (type==TacsKeyBoardButtonType_clear_other) {
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self setTitle:@"←" forState:UIControlStateNormal];
    }
    if (type==TacsKeyBoardButtonType_sepec_other) {
        [self setTitle:@" " forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17 weight:1.05];
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    }
    if (type==TacsKeyBoardButtonType_down_other) {
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self setTitle:@"完成" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    if (type==TacsKeyBoardButtonType_123) {
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self setTitle:@"123" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    if (type==TacsKeyBoardButtonType_abc) {
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self setTitle:@"ABC" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    if (type==TacsKeyBoardButtonType_fuhao) {
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self setTitle:@"符" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor lightColor:[UIColor whiteColor] darkColor:[UIColor darkGrayColor]];
    if (self.type==TacsKeyBoardButtonType_down) {
        color = [UIColor systemBlueColor];
    }
    if (self.type==TacsKeyBoardButtonType_clear || self.type==TacsKeyBoardButtonType_shift) {
        color = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    }
    if (self.selected && self.type==TacsKeyBoardButtonType_shift_other) {
        color = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    }
    UIColor *shadow = [UIColor lightGrayColor];
    CGSize shadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat shadowBlurRadius = 0;
    
    UIBezierPath *roundedRectanglePath =
    [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 1) cornerRadius:5];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    [color setFill];
    [roundedRectanglePath fill];
    CGContextRestoreGState(context);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    AudioServicesPlaySystemSound(1104);
}

@end
