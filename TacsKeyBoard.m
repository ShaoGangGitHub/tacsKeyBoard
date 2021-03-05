//
//  TacsKeyBoard.m
//  YXGovermentSDK
//
//  Created by shg on 2019/9/30.
//  Copyright © 2019 yx. All rights reserved.
//

#import "TacsKeyBoard.h"

#define mergeSep 8
#define mergeSepzimu 3

@implementation TacsKeyBoard

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initsubs];
    }
    return self;
}

- (void)initsubs
{
    CGFloat height1 = 260;
    CGFloat height2 = 50;
    if ([UIScreen mainScreen].bounds.size.width<375) {
        height1 = 200;
        height2 = 40;
    }
    self.inputView = [[TacsInputView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height1)];
    __weak typeof(self) weakSelf = self;
    self.inputView.setTextffiled = ^UITextField * _Nonnull(TacsKeyBoardButton * _Nonnull button) {
        return weakSelf.setTextffiled(button);
    };
    self.inputAccessoryView = [[TacsInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height2)];
    self.inputAccessoryView.delegate = self;
}

- (void)choseKeyBoardWithIndex:(NSInteger)index
{
    [self.inputView changeIndex:index];
}

- (void)tapActionPassWord:(TacsKeyBoardButton *)sender
{
    [self.inputView tapPassWordKeyBoard:sender];
}

- (void)setKeyBaordType:(TacsKeyBoardType)keyBaordType
{
    _keyBaordType = keyBaordType;
    self.inputView.keyBaordType = keyBaordType;
    self.inputAccessoryView.keyBaordType = keyBaordType;
}

@end

@interface TacsInputView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *buts;
@property (nonatomic,strong) NSMutableArray *butszimu;
@property (nonatomic,strong) NSMutableArray *butsfuhao;
@property (nonatomic,strong) NSMutableArray *butsother;
@property (nonatomic,strong) NSMutableArray *butszimuother;
@property (nonatomic,strong) NSMutableArray *butsfuhaoother;

@end
@implementation TacsInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1] darkColor:[UIColor groupTableViewBackgroundColor]];
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = self.backgroundColor;
    self.scrollView.contentSize = CGSizeMake(7*self.bounds.size.width, self.bounds.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.scrollEnabled = NO;
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    [self shuzi];
    [self zimu];
    [self fuhao];
    [self idCard];
    [self shuziother];
    [self zimuother];
    [self fuhaoother];
}

- (void)shuziother
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = self.backgroundColor;
    [self.scrollView addSubview:view];
    CGFloat width = (self.bounds.size.width-4*mergeSep)/3;
    CGFloat hetght = (self.bounds.size.height-5*mergeSep)/4;
    for (int i = 0; i<4; i++) {
        for (int j = 0; j<3; j++) {
            if (i==3 && j==0){
                continue;
            }else if (i==3 && j==2){
                continue;
            }
            TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(j*(width+mergeSep)+mergeSep, i*(mergeSep+hetght), width, hetght);
            [but addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:but];
            but.type = TacsKeyBoardButtonType_normal;
            [self.butsother addObject:but];
        }
    }
    TacsKeyBoardButton *butabc = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butabc.frame = CGRectMake(mergeSep, 3*mergeSep+3*hetght,(width-mergeSep)/2, hetght);
    [butabc addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
    butabc.type = TacsKeyBoardButtonType_abc;
    [view addSubview:butabc];
    TacsKeyBoardButton *butfuhao = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butfuhao.frame = CGRectMake(butabc.frame.origin.x+butabc.frame.size.width+mergeSep, 3*mergeSep+3*hetght,(width-mergeSep)/2, hetght);
    [butfuhao addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
    butfuhao.type = TacsKeyBoardButtonType_fuhao;
    [view addSubview:butfuhao];
    TacsKeyBoardButton *butclear = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butclear.frame = CGRectMake(self.bounds.size.width-width-mergeSep, 3*mergeSep+3*hetght,(width-mergeSep)/2,hetght);
    [butclear addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
    butclear.type = TacsKeyBoardButtonType_clear_other;
    [view addSubview:butclear];
    TacsKeyBoardButton *butdown = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butdown.frame = CGRectMake(butclear.bounds.size.width+mergeSep+butclear.frame.origin.x, 3*mergeSep+3*hetght, (width-mergeSep)/2, hetght);
    [butdown addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
    butdown.type = TacsKeyBoardButtonType_down_other;
    [view addSubview:butdown];
}

- (void)zimuother
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(4*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = self.backgroundColor;
    [self.scrollView addSubview:view];
    CGFloat width = (self.bounds.size.width-2*mergeSep-9*mergeSepzimu)/10;
    CGFloat hetght = (self.bounds.size.height-5*mergeSep)/4;
    NSArray *temp1 = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"];
    for (int i = 0; i<10; i++) {
        TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(i*(width+mergeSepzimu)+mergeSep, 0, width, hetght);
        [but addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitle:temp1[i] forState:UIControlStateNormal];
        [view addSubview:but];
        but.type = TacsKeyBoardButtonType_normal;
        [self.butszimuother addObject:but];
    }
    NSArray *temp2 = @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"];
    CGFloat leftsep = (self.bounds.size.width-8*mergeSepzimu-9*width)/2;
    for (int i = 0; i<9; i++) {
        TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(i*(width+mergeSepzimu)+leftsep, 1*mergeSep+hetght, width, hetght);
        [but addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitle:temp2[i] forState:UIControlStateNormal];
        [view addSubview:but];
        but.type = TacsKeyBoardButtonType_normal;
        [self.butszimuother addObject:but];
    }
    NSArray *temp3 = @[@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    CGFloat leftsep1 = (self.bounds.size.width-6*mergeSepzimu-7*width)/2;
    for (int i = 0; i<7; i++) {
        TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(i*(width+mergeSepzimu)+leftsep1, 2*mergeSep+2*hetght, width, hetght);
        [but addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitle:temp3[i] forState:UIControlStateNormal];
        [view addSubview:but];
        but.type = TacsKeyBoardButtonType_normal;
        [self.butszimuother addObject:but];
    }
    TacsKeyBoardButton *butshift = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butshift.frame = CGRectMake(mergeSep, 2*mergeSep+2*hetght, leftsep1-mergeSep-mergeSepzimu, hetght);
    [butshift addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    butshift.type = TacsKeyBoardButtonType_shift_other;
    [view addSubview:butshift];
    TacsKeyBoardButton *butclear = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butclear.frame = CGRectMake(self.bounds.size.width-leftsep1+mergeSepzimu, 2*mergeSep+2*hetght, leftsep1-mergeSep-mergeSepzimu, hetght);
    [butclear addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    butclear.type = TacsKeyBoardButtonType_clear_other;
    [view addSubview:butclear];
    TacsKeyBoardButton *but123 = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    but123.frame = CGRectMake(mergeSep, 3*mergeSep+3*hetght,2*width, hetght);
    [but123 addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    but123.type = TacsKeyBoardButtonType_123;
    [view addSubview:but123];
    TacsKeyBoardButton *butfuhao = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butfuhao.frame = CGRectMake(but123.frame.origin.x+but123.frame.size.width+mergeSepzimu, 3*mergeSep+3*hetght,2*width, hetght);
    [butfuhao addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    butfuhao.type = TacsKeyBoardButtonType_fuhao;
    [view addSubview:butfuhao];
    TacsKeyBoardButton *butsep = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butsep.frame = CGRectMake(butfuhao.frame.origin.x+butfuhao.frame.size.width+mergeSepzimu, 3*mergeSep+3*hetght,self.bounds.size.width-5*width-butshift.bounds.size.width-3*mergeSepzimu-2*mergeSep, hetght);
    [butsep addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    butsep.type = TacsKeyBoardButtonType_sepec_other;
    [view addSubview:butsep];
    TacsKeyBoardButton *butdown = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butdown.frame = CGRectMake(butsep.bounds.size.width+mergeSepzimu+butsep.frame.origin.x, 3*mergeSep+3*hetght, butclear.bounds.size.width+mergeSepzimu+width, hetght);
    [butdown addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    butdown.type = TacsKeyBoardButtonType_down_other;
    [view addSubview:butdown];
}

- (void)fuhaoother
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(6*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = self.backgroundColor;
    [self.scrollView addSubview:view];
    CGFloat width = (self.bounds.size.width-2*mergeSep-9*mergeSepzimu)/10;
    CGFloat hetght = (self.bounds.size.height-5*mergeSep)/4;
    NSArray *temp = @[@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"=",@"_",@"\\",@"|",@"~",@"<",@">",@"$",@".",@",",@"?",@"!",@"'",@"-",@"/",@":",@";",@"(",@")",@"&",@"@",@"`",@"\""];
    NSInteger index = 0;
    for (int i = 0; i<4; i++) {
        for (int j = 0; j<10; j++) {
            if ((i==3 && (j==0 || j==1 || j==2 || j==4 || j==5 || j==7 || j==8 || j==9))) {
                continue;
            }
            TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(j*(width+mergeSepzimu)+mergeSep, i*(mergeSep+hetght), width, hetght);
            [but addTarget:self action:@selector(tapfuhao:) forControlEvents:UIControlEventTouchUpInside];
            [but setTitle:temp[index] forState:UIControlStateNormal];
            [view addSubview:but];
            but.type = TacsKeyBoardButtonType_normal;
            [self.butsfuhaoother addObject:but];
            index++;
        }
    }
    TacsKeyBoardButton *butabc = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butabc.frame = CGRectMake(mergeSep, 3*mergeSep+3*hetght,(3*width+mergeSepzimu)/2, hetght);
    [butabc addTarget:self action:@selector(tapfuhao:) forControlEvents:UIControlEventTouchUpInside];
    butabc.type = TacsKeyBoardButtonType_abc;
    [view addSubview:butabc];
    TacsKeyBoardButton *but123 = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    but123.frame = CGRectMake(mergeSep+butabc.bounds.size.width+mergeSepzimu, 3*mergeSep+3*hetght,(3*width+mergeSepzimu)/2, hetght);
    [but123 addTarget:self action:@selector(tapfuhao:) forControlEvents:UIControlEventTouchUpInside];
    but123.type = TacsKeyBoardButtonType_123;
    [view addSubview:but123];
    TacsKeyBoardButton *butsep = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butsep.frame = CGRectMake(mergeSep+4*(width+mergeSepzimu), 3*mergeSep+3*hetght,2*width+mergeSepzimu, hetght);
    [butsep addTarget:self action:@selector(tapfuhao:) forControlEvents:UIControlEventTouchUpInside];
    butsep.type = TacsKeyBoardButtonType_sepec_other;
    [view addSubview:butsep];
    TacsKeyBoardButton *butclear = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butclear.frame = CGRectMake(self.bounds.size.width-2*mergeSepzimu-mergeSep-3*width, 3*mergeSep+3*hetght,(3*width+mergeSepzimu)/2, hetght);
    [butclear addTarget:self action:@selector(tapfuhao:) forControlEvents:UIControlEventTouchUpInside];
    butclear.type = TacsKeyBoardButtonType_clear_other;
    [view addSubview:butclear];
    TacsKeyBoardButton *butdown = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butdown.frame = CGRectMake(butclear.bounds.size.width+mergeSepzimu+butclear.frame.origin.x, 3*mergeSep+3*hetght, (3*width+mergeSepzimu)/2, hetght);
    [butdown addTarget:self action:@selector(tapfuhao:) forControlEvents:UIControlEventTouchUpInside];
    butdown.type = TacsKeyBoardButtonType_down_other;
    [view addSubview:butdown];
    
}

- (void)shuzi
{
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = self.backgroundColor;
    [self.scrollView addSubview:view];
    CGFloat width = (self.bounds.size.width-4*mergeSep)/3;
    CGFloat hetght = (self.bounds.size.height-5*mergeSep)/4;
    for (int i = 0; i<4; i++) {
        for (int j = 0; j<3; j++) {
            TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(j*(width+mergeSep)+mergeSep, i*(mergeSep+hetght), width, hetght);
            [but addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:but];
            if (i==2 && j==2){
                but.type = TacsKeyBoardButtonType_clear;
            }else if (i==3 && j==2){
                but.type = but.type = TacsKeyBoardButtonType_down;
            }else{
                but.type = TacsKeyBoardButtonType_normal;
                [self.buts addObject:but];
            }
        }
    }
}

- (void)idCard
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(3*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = self.backgroundColor;
    [self.scrollView addSubview:view];
    CGFloat width = (self.bounds.size.width-4*mergeSep)/3;
    CGFloat hetght = (self.bounds.size.height-5*mergeSep)/4;
    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSInteger index = 0;
    for (int i = 0; i<4; i++) {
        for (int j = 0; j<3; j++) {
            if (i==2 && j==2){
                continue;
            }
            TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(j*(width+mergeSep)+mergeSep, i*(mergeSep+hetght), width, hetght);
            [but addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:but];
            if (i==3 && j==2){
                but.type = but.type = TacsKeyBoardButtonType_down;
            }else{
                but.type = TacsKeyBoardButtonType_normal;
                [but setTitle:arr[index] forState:UIControlStateNormal];
                index++;
            }
        }
    }
    
    TacsKeyBoardButton *butclear = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butclear.frame = CGRectMake(self.bounds.size.width-width/2-mergeSep/2, 2*mergeSep+2*hetght, width/2-mergeSep/2, hetght);
    [butclear addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
    butclear.type = TacsKeyBoardButtonType_clear;
    [view addSubview:butclear];
    
    TacsKeyBoardButton *butX = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butX.frame = CGRectMake(self.bounds.size.width-width-mergeSep, 2*mergeSep+2*hetght, width/2-mergeSep/2, hetght);
    [butX addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
    butX.type = TacsKeyBoardButtonType_normal;
    [butX setTitle:@"X" forState:UIControlStateNormal];
    [view addSubview:butX];
}

- (void)tapshuzi:(TacsKeyBoardButton *)sender
{
    [self tapAction:sender];
}
//产生任意范围内任意数量的随机数(使用此方法)
-(NSArray*)randomDataFromLower:(NSInteger)lower
                      toHigher:(NSInteger)higher
                  withQuantity:(NSInteger)quantity{
    
    NSMutableArray *myRandomNumbers=[NSMutableArray array];
    if (!quantity||quantity>(higher-lower)+1) {
         quantity=(higher-lower)+1;
        
    }
    while (myRandomNumbers.count!=quantity) {
       NSInteger myNumber=arc4random_uniform((uint32_t)(higher+1-lower))+(uint32_t)lower;
        if (![myRandomNumbers containsObject: @(myNumber)]) {
            [myRandomNumbers addObject:@(myNumber)];
        }
    }
    return [myRandomNumbers copy];//可变数组变成不可变
}
- (void)zimu
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = self.backgroundColor;
    [self.scrollView addSubview:view];
    CGFloat width = (self.bounds.size.width-2*mergeSep-9*mergeSepzimu)/10;
    CGFloat hetght = (self.bounds.size.height-5*mergeSep)/4;
    NSArray *temp1 = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"];
    for (int i = 0; i<10; i++) {
        TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(i*(width+mergeSepzimu)+mergeSep, 0, width, hetght);
        [but addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitle:temp1[i] forState:UIControlStateNormal];
        [view addSubview:but];
        but.type = TacsKeyBoardButtonType_normal;
        [self.butszimu addObject:but];
    }
    NSArray *temp2 = @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"];
    CGFloat leftsep = (self.bounds.size.width-8*mergeSepzimu-9*width)/2;
    for (int i = 0; i<9; i++) {
        TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(i*(width+mergeSepzimu)+leftsep, 1*mergeSep+hetght, width, hetght);
        [but addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitle:temp2[i] forState:UIControlStateNormal];
        [view addSubview:but];
        but.type = TacsKeyBoardButtonType_normal;
        [self.butszimu addObject:but];
    }
    NSArray *temp3 = @[@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    CGFloat leftsep1 = (self.bounds.size.width-6*mergeSepzimu-7*width)/2;
    for (int i = 0; i<7; i++) {
        TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(i*(width+mergeSepzimu)+leftsep1, 2*mergeSep+2*hetght, width, hetght);
        [but addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitle:temp3[i] forState:UIControlStateNormal];
        [view addSubview:but];
        but.type = TacsKeyBoardButtonType_normal;
        [self.butszimu addObject:but];
    }
    TacsKeyBoardButton *butshift = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butshift.frame = CGRectMake(mergeSep, 2*mergeSep+2*hetght, leftsep1-mergeSep-mergeSepzimu, hetght);
    [butshift addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    butshift.type = TacsKeyBoardButtonType_shift;
    [view addSubview:butshift];
    TacsKeyBoardButton *butclear = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butclear.frame = CGRectMake(self.bounds.size.width-leftsep1+mergeSepzimu, 2*mergeSep+2*hetght, leftsep1-mergeSep-mergeSepzimu, hetght);
    [butclear addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    butclear.type = TacsKeyBoardButtonType_clear;
    [view addSubview:butclear];
    TacsKeyBoardButton *butsep = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butsep.frame = CGRectMake(mergeSep, 3*mergeSep+3*hetght, butshift.bounds.size.width+6*(mergeSepzimu+width), hetght);
    [butsep addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    butsep.type = TacsKeyBoardButtonType_sepec;
    [view addSubview:butsep];
    TacsKeyBoardButton *butdown = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butdown.frame = CGRectMake(butsep.bounds.size.width+mergeSepzimu+mergeSep, 3*mergeSep+3*hetght, butclear.bounds.size.width+mergeSepzimu+width, hetght);
    [butdown addTarget:self action:@selector(tapzimu:) forControlEvents:UIControlEventTouchUpInside];
    butdown.type = TacsKeyBoardButtonType_down;
    [view addSubview:butdown];
}
- (void)tapzimu:(TacsKeyBoardButton *)sender
{
    [self tapAction:sender];
}
- (void)fuhao
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(2*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = self.backgroundColor;
    [self.scrollView addSubview:view];
    CGFloat width = (self.bounds.size.width-2*mergeSep-9*mergeSepzimu)/10;
    CGFloat hetght = (self.bounds.size.height-5*mergeSep)/4;
    NSArray *temp = @[@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"=",@"_",@"-",@"/",@":",@";",@"(",@")",@"$",@"&",@"@",@".",@",",@"?",@"!",@"'",@"\\",@"|",@"~",@"`",@"<",@">",@"€",@"£",@"￥",@"\""];
    NSInteger index = 0;
    for (int i = 0; i<4; i++) {
        for (int j = 0; j<10; j++) {
            if ((i==2 && (j==8 || j==9))||(i==3 && (j==7 || j==8 || j==9))) {
                continue;
            }
            TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(j*(width+mergeSepzimu)+mergeSep, i*(mergeSep+hetght), width, hetght);
            [but addTarget:self action:@selector(tapfuhao:) forControlEvents:UIControlEventTouchUpInside];
            [but setTitle:temp[index] forState:UIControlStateNormal];
            [view addSubview:but];
            but.type = TacsKeyBoardButtonType_normal;
            [self.butsfuhao addObject:but];
            index++;
        }
    }
    TacsKeyBoardButton *butclear = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butclear.frame = CGRectMake(self.bounds.size.width-(2*width+mergeSepzimu+mergeSep), 2*mergeSep+2*hetght, mergeSepzimu+2*width, hetght);
    [butclear addTarget:self action:@selector(tapfuhao:) forControlEvents:UIControlEventTouchUpInside];
    butclear.type = TacsKeyBoardButtonType_clear;
    [view addSubview:butclear];
    TacsKeyBoardButton *butdown = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
    butdown.frame = CGRectMake(self.bounds.size.width-(3*width+2*mergeSepzimu+mergeSep), 3*mergeSep+3*hetght, 2*mergeSepzimu+3*width, hetght);
    [butdown addTarget:self action:@selector(tapfuhao:) forControlEvents:UIControlEventTouchUpInside];
    butdown.type = TacsKeyBoardButtonType_down;
    [view addSubview:butdown];
}

- (void)tapfuhao:(TacsKeyBoardButton *)sender
{
    [self tapAction:sender];
}

- (void)tapAction:(TacsKeyBoardButton *)sender
{
    UITextField *textfiled = self.setTextffiled(sender);
    NSMutableString *str = [NSMutableString stringWithString:textfiled.text];
    if (sender.type==TacsKeyBoardButtonType_shift) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            for (TacsKeyBoardButton *charBtn in self.butszimu) {
                if (charBtn.type==TacsKeyBoardButtonType_normal) {
                    [charBtn setTitle:[charBtn.currentTitle uppercaseString] forState:UIControlStateNormal];
                }
            }
        }else{
            for (TacsKeyBoardButton *charBtn in self.butszimu) {
                if (charBtn.type==TacsKeyBoardButtonType_normal) {
                    [charBtn setTitle:[charBtn.currentTitle lowercaseString] forState:UIControlStateNormal];
                }
            }
        }
    }else if (sender.type==TacsKeyBoardButtonType_normal){
        NSRange range = textfiled.selectedRange;
        [str insertString:sender.currentTitle atIndex:range.location];
        textfiled.text = str.mutableCopy;
        textfiled.selectedRange = NSMakeRange(range.location+1, range.length);
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:textfiled userInfo:nil];
    }else if (sender.type==TacsKeyBoardButtonType_down||sender.type==TacsKeyBoardButtonType_down_other){
        [textfiled resignFirstResponder];
    }else if (sender.type==TacsKeyBoardButtonType_sepec){
        
    }else if (sender.type==TacsKeyBoardButtonType_clear||sender.type==TacsKeyBoardButtonType_clear_other){
        if ([str isEqualToString:@""]){
            return;
        }
        NSRange selRange = textfiled.selectedRange;
        if (selRange.location==0) {
            return;
        }
        NSRange range = {selRange.location-1,1};
        [str deleteCharactersInRange:range];
        textfiled.text = str.mutableCopy;
        textfiled.selectedRange = NSMakeRange(selRange.location-1, selRange.length);
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:textfiled userInfo:nil];
    }else if (sender.type==TacsKeyBoardButtonType_shift_other) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            for (TacsKeyBoardButton *charBtn in self.butszimuother) {
                if (charBtn.type==TacsKeyBoardButtonType_normal) {
                    [charBtn setTitle:[charBtn.currentTitle uppercaseString] forState:UIControlStateNormal];
                }
            }
        }else{
            for (TacsKeyBoardButton *charBtn in self.butszimuother) {
                if (charBtn.type==TacsKeyBoardButtonType_normal) {
                    [charBtn setTitle:[charBtn.currentTitle lowercaseString] forState:UIControlStateNormal];
                }
            }
        }
    }else if (sender.type==TacsKeyBoardButtonType_fuhao){
        [self.scrollView setContentOffset:CGPointMake(6*self.bounds.size.width, 0)];
    }else if (sender.type==TacsKeyBoardButtonType_123){
        [self.scrollView setContentOffset:CGPointMake(5*self.bounds.size.width, 0)];
        NSArray *shuzi = [self randomDataFromLower:0 toHigher:9 withQuantity:10];
        [self.butsother enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = obj;
            NSNumber *number = [shuzi objectAtIndex:idx];
            NSString *title = number.stringValue;
            [button setTitle:title forState:UIControlStateNormal];
        }];
    }else if (sender.type==TacsKeyBoardButtonType_abc){
        [self.scrollView setContentOffset:CGPointMake(4*self.bounds.size.width, 0)];
    }
}

- (void)changeIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index*self.bounds.size.width, 0)];
    if (index==0) {
        NSArray *shuzi = [self randomDataFromLower:0 toHigher:9 withQuantity:10];
        [self.buts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = obj;
            NSNumber *number = [shuzi objectAtIndex:idx];
            NSString *title = number.stringValue;
            [button setTitle:title forState:UIControlStateNormal];
        }];
    }
}

- (void)tapPassWordKeyBoard:(TacsKeyBoardButton *)sender
{
    [self tapAction:sender];
}

- (void)setKeyBaordType:(TacsKeyBoardType)keyBaordType
{
    _keyBaordType = keyBaordType;
    if (keyBaordType==TacsKeyBoardType_Normal) {
        return;
    }else if (keyBaordType==TacsKeyBoardType_IDCard){
        [self.scrollView setContentOffset:CGPointMake(3*self.bounds.size.width, 0)];
    }else if (keyBaordType==TacsKeyBoardType_Number){
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
        NSArray *shuzi = [self randomDataFromLower:0 toHigher:9 withQuantity:10];
        [self.buts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = obj;
            NSNumber *number = [shuzi objectAtIndex:idx];
            NSString *title = number.stringValue;
            [button setTitle:title forState:UIControlStateNormal];
        }];
    }else if (keyBaordType==TacsKeyBoardType_Normal_Other){
        [self.scrollView setContentOffset:CGPointMake(4*self.bounds.size.width, 0)];
    }else if (keyBaordType==TacsKeyBoardType_PassWord){
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    }
}

- (NSMutableArray *)buts
{
    if (!_buts) {
        _buts = [NSMutableArray array];
    }
    return _buts;
}
- (NSMutableArray *)butszimu
{
    if (!_butszimu) {
        _butszimu = [NSMutableArray array];
    }
    return _butszimu;
}
- (NSMutableArray *)butsfuhao
{
    if (!_butsfuhao) {
        _butsfuhao = [NSMutableArray array];
    }
    return _butsfuhao;
}
- (NSMutableArray *)butsother
{
    if (!_butsother) {
        _butsother = [NSMutableArray array];
    }
    return _butsother;
}
- (NSMutableArray *)butszimuother
{
    if (!_butszimuother) {
        _butszimuother = [NSMutableArray array];
    }
    return _butszimuother;
}
- (NSMutableArray *)butsfuhaoother
{
    if (!_butsfuhaoother) {
        _butsfuhaoother = [NSMutableArray array];
    }
    return _butsfuhaoother;
}

@end

@implementation TacsInputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1] darkColor:[UIColor groupTableViewBackgroundColor]];
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height)];
    label.text = @"安全键盘";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = TacsReInfo.mainColor;
    label.font = [UIFont systemFontOfSize:18];
    [self addSubview:label];
    
    UIButton *shuzi = [UIButton buttonWithType:UIButtonTypeCustom];
    [shuzi setImage:[UIImage name:@"number"] forState:UIControlStateNormal];
    [shuzi setImage:[UIImage name:@"chosennumber"] forState:UIControlStateSelected];
    shuzi.frame = CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2/3, self.bounds.size.height);
    [shuzi addTarget:self action:@selector(choseshuzi:) forControlEvents:UIControlEventTouchUpInside];
    shuzi.tag = 100;
    [self addSubview:shuzi];
    
    UIButton *zimu = [UIButton buttonWithType:UIButtonTypeCustom];
    [zimu setImage:[UIImage name:@"charactor"] forState:UIControlStateNormal];
    [zimu setImage:[UIImage name:@"chosencharactor"] forState:UIControlStateSelected];
    zimu.frame = CGRectMake(shuzi.frame.origin.x+shuzi.frame.size.width, 0, self.bounds.size.width/2/3, self.bounds.size.height);
    [zimu addTarget:self action:@selector(chosezimu:) forControlEvents:UIControlEventTouchUpInside];
    zimu.tag = 200;
    zimu.selected  = YES;
    [self addSubview:zimu];
    
    UIButton *fuhao = [UIButton buttonWithType:UIButtonTypeCustom];
    [fuhao setImage:[UIImage name:@"sign"] forState:UIControlStateNormal];
    [fuhao setImage:[UIImage name:@"chosensign"] forState:UIControlStateSelected];
    fuhao.frame = CGRectMake(zimu.frame.origin.x+zimu.frame.size.width, 0, self.bounds.size.width/2/3, self.bounds.size.height);
    [fuhao addTarget:self action:@selector(chosefuhao:) forControlEvents:UIControlEventTouchUpInside];
    fuhao.tag = 300;
    [self addSubview:fuhao];
}

- (void)choseshuzi:(UIButton *)sender
{
    sender.selected = YES;
    UIButton *zimu = [self viewWithTag:200];
    UIButton *fuhao = [self viewWithTag:300];
    zimu.selected = NO;
    fuhao.selected = NO;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(choseKeyBoardWithIndex:)]) {
        [self.delegate choseKeyBoardWithIndex:0];
    }
}
- (void)chosezimu:(UIButton *)sender
{
    sender.selected = YES;
    UIButton *shuzi = [self viewWithTag:100];
    UIButton *fuhao = [self viewWithTag:300];
    shuzi.selected = NO;
    fuhao.selected = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(choseKeyBoardWithIndex:)]) {
        [self.delegate choseKeyBoardWithIndex:1];
    }
}
- (void)chosefuhao:(UIButton *)sender
{
    sender.selected = YES;
    UIButton *zimu = [self viewWithTag:200];
    UIButton *shuzi = [self viewWithTag:100];
    zimu.selected = NO;
    shuzi.selected = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(choseKeyBoardWithIndex:)]) {
        [self.delegate choseKeyBoardWithIndex:2];
    }
}

- (void)setKeyBaordType:(TacsKeyBoardType)keyBaordType
{
    _keyBaordType = keyBaordType;
    if (keyBaordType==TacsKeyBoardType_Normal) {
        return;
    }else if (keyBaordType==TacsKeyBoardType_IDCard || keyBaordType==TacsKeyBoardType_Number || keyBaordType==TacsKeyBoardType_Normal_Other){
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.backgroundColor = self.backgroundColor;
        label.text = @"安全键盘";
        label.textColor = TacsReInfo.mainColor;
        label.font = [UIFont systemFontOfSize:18 weight:1.05];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [self addSubview:label];
    }else if (keyBaordType==TacsKeyBoardType_PassWord){
        UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor = self.backgroundColor;
        [self addSubview:backView];
        CGFloat width = (self.bounds.size.width-2*mergeSep-9*mergeSepzimu)/10;
        CGFloat hetght = (self.bounds.size.height-mergeSep-4);
        NSArray *temp1 = [self randomDataFromLower:0 toHigher:9 withQuantity:10];
        for (int i = 0; i<temp1.count; i++) {
            TacsKeyBoardButton *but = [TacsKeyBoardButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(i*(width+mergeSepzimu)+mergeSep, 4, width, hetght);
            [but addTarget:self action:@selector(tapshuzi:) forControlEvents:UIControlEventTouchUpInside];
            NSNumber *number = [temp1 objectAtIndex:i];
            NSString *title = number.stringValue;
            [but setTitle:title forState:UIControlStateNormal];
            but.type = TacsKeyBoardButtonType_normal;
            [backView addSubview:but];
        }
    }
}

- (void)tapshuzi:(TacsKeyBoardButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapActionPassWord:)]) {
        [self.delegate tapActionPassWord:sender];
    }
}

//产生任意范围内任意数量的随机数(使用此方法)
- (NSArray *)randomDataFromLower:(NSInteger)lower
                      toHigher:(NSInteger)higher
                  withQuantity:(NSInteger)quantity{
    
    NSMutableArray *myRandomNumbers=[NSMutableArray array];
    if (!quantity||quantity>(higher-lower)+1) {
         quantity=(higher-lower)+1;
        
    }
    while (myRandomNumbers.count!=quantity) {
       NSInteger myNumber=arc4random_uniform((uint32_t)(higher+1-lower))+(uint32_t)lower;
        if (![myRandomNumbers containsObject: @(myNumber)]) {
            [myRandomNumbers addObject:@(myNumber)];
        }
    }
    return [myRandomNumbers copy];//可变数组变成不可变
}

@end
