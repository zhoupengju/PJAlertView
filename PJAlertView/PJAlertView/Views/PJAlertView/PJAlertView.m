//
//  PJAlertView.m
//  PJAlertView
//
//  Created by hetane on 16/11/24.
//  Copyright © 2016年 周鹏钜. All rights reserved.
//

#import "PJAlertView.h"

@interface PJAlertView ()
{

    BOOL closeOnTouchUpInside;
}

@property (nonatomic, strong) UIView *dialogContainer;

@property (nonatomic, strong) UIView *dialogView;

@end

@implementation PJAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        
        closeOnTouchUpInside = YES;
        
        self.buttonTitles = @[@"知道啦"];
    }
    return self;
}

- (void)show {
    
    // 1. 创建父view (弹框) 并添加
    _dialogView = self.dialogContainer;
    
    // 2. 添加中间件
    
    // 3. 添加控件和控件出来的动画
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addCurrentViewToSuperView:_dialogView];
}

- (void)addCurrentViewToSuperView:(UIView *)dialogView {

    dialogView.layer.opacity = 0.5f;
    dialogView.layer.transform = CATransform3DMakeScale(0.6f, 0.6f, 0.6f);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        dialogView.layer.opacity = 1.0f;
        dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:nil];
}

-(UIView *)dialogContainer {

    if (!_dialogContainer) {
    
        _dialogContainer = [[UIView alloc] init];
        [self addSubview:_dialogContainer];
        
        [_dialogContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_bottom).multipliedBy(0.25);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@223);
            make.height.equalTo(@143);
        }];
        
        // 设置角落半径的颜色
        int cornerRadius = 7;
        _dialogContainer.layer.cornerRadius = cornerRadius;  // 设置圆角的大小, 不写这句话, 就不会出现圆角
        _dialogContainer.layer.borderColor = [kRGBColor(0xe4e4e4) CGColor]; // 设置圆角的颜色
        _dialogContainer.layer.borderWidth = 1;// 设置圆角的宽度
        _dialogContainer.layer.masksToBounds = YES;
        
        // 设置背景色
        _dialogContainer.layer.backgroundColor = kRGBColor(0xf6f6f6).CGColor;
    }
    return _dialogContainer;
}

-(void)close {

    CATransform3D currentTransform = self.dialogContainer.layer.transform;
    
    // opacity是layer的透明度, 会影响自己的透明度, 也会影响子view的透明度, 但不会影响性能.
    self.dialogContainer.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        
        self.backgroundColor = [UIColor whiteColor];
        self.dialogContainer.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
        self.dialogContainer.layer.opacity = 1.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (!closeOnTouchUpInside) {
    
        return;
    }
    
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[PJAlertView class]]) {
    
        [self close];
    }
}

@end
