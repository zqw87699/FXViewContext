//
//  FXViewContext.m
//  TTTT
//
//  Created by 张大宗 on 2017/4/10.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "FXViewContext.h"
#import "Masonry.h"
#import "ReactiveObjC.h"
#import "FXCommon.h"
#import "FXAnimateContext.h"

@interface FXViewContext()

@property (nonatomic, assign) NSTimeInterval animatedDuration;

@property (nonatomic, assign) BOOL hasBackground;

@property (nonatomic, assign) CGFloat backgroundAlpha;

@property (nonatomic, assign) FXViewPushType pushType;

@property (nonatomic, assign) BOOL touchClose;

@end

@implementation FXViewContext

DEF_SINGLETON_INIT(FXViewContext)

- (void)singleInit{
    self.animatedDuration = 0.25f;
    self.hasBackground = YES;
    self.backgroundAlpha = 0.3f;
    self.pushType = FXViewPushTypeAlert;
    self.touchClose = YES;
}

- (UIView*)formatView:(UIView<IFXViewShowProtocol> *)view Root:(UIView *)root{
    BOOL hasbg = self.hasBackground;
    CGFloat alpha = self.backgroundAlpha;
    if ([view respondsToSelector:@selector(hasBackground)]) {
        hasbg = [view hasBackground];
        if ([view respondsToSelector:@selector(backgroundAlpha)]) {
            alpha = [view backgroundAlpha];
        }
    }
    UIView *father = [[UIView alloc] init];
    [father setBackgroundColor:[UIColor clearColor]];
    [root addSubview:father];
    [father mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(root);
    }];
    if (hasbg) {
        UIButton *bgv = [[UIButton alloc] init];
        [bgv setBackgroundColor:[UIColor blackColor]];
        [bgv setAlpha:alpha];
        FX_WEAK_REF_TYPE selfObject = self;
        [[bgv rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [selfObject closeView:view];
        }];
        [father addSubview:bgv];
        [bgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(father);
        }];
    }
    [father addSubview:view];
    [root layoutIfNeeded];//强制绘制
    return father;
}

- (void)showView:(UIView<IFXViewShowProtocol> *)view Root:(UIView *)root{
    if (!view.superview && view) {
        
        [self formatView:view Root:root];
        
        FXViewPushType type = self.pushType;
        if ([view respondsToSelector:@selector(pushType)]) {
            type = [view pushType];
        }
        NSTimeInterval duration = self.animatedDuration;
        if ([view respondsToSelector:@selector(animatedDuration)]) {
            duration = [view animatedDuration];
        }
        switch (type) {
            case FXViewPushTypeAlert:{
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(view.superview.mas_centerX);
                    make.centerY.equalTo(view.superview.mas_centerY);
                    make.width.equalTo(@([view viewSize].width));
                    make.height.equalTo(@([view viewSize].height));
                }];
                [view.superview layoutIfNeeded];
                [[FXAnimateContext sharedInstance] alertView:view Duration:duration Block:nil];
                break;
            }
            case FXViewPushTypeLeft:{
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(view.superview.mas_top);
                    make.bottom.equalTo(view.superview.mas_bottom);
                    make.left.equalTo(@(-[view viewSize].width));
                    make.width.equalTo(@([view viewSize].width));
                }];
                [view.superview layoutIfNeeded];//强制绘制
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:[view viewSize].width Block:nil];
                break;
            }
            case FXViewPushTypeRight:{
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(view.superview.mas_top);
                    make.bottom.equalTo(view.superview.mas_bottom);
                    make.left.equalTo(view.superview.mas_right);
                    make.width.equalTo(@([view viewSize].width));
                }];
                [view.superview layoutIfNeeded];//强制绘制
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:-[view viewSize].width Block:nil];
                break;
            }
            case FXViewPushTypeTop:{
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(view.superview.mas_left);
                    make.right.equalTo(view.superview.mas_right);
                    make.top.equalTo(@(-[view viewSize].height));
                    make.height.equalTo(@([view viewSize].height));
                }];
                [view.superview layoutIfNeeded];//强制绘制
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:[view viewSize].height Block:nil];
                break;
            }
            case FXViewPushTypeBottom:{
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(view.superview.mas_left);
                    make.right.equalTo(view.superview.mas_right);
                    make.top.equalTo(view.superview.mas_bottom);
                    make.height.equalTo(@([view viewSize].height));
                }];
                [view.superview layoutIfNeeded];//强制绘制
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:-[view viewSize].height Block:nil];
                break;
            }
            default:
                break;
        }
    }
}

- (void)closeView:(UIView<IFXViewShowProtocol> *)view{
    if (view && view.superview) {
        
        [view.superview layoutIfNeeded];
        
        FXViewPushType type = self.pushType;
        if ([view respondsToSelector:@selector(pushType)]) {
            type = [view pushType];
        }
        
        NSTimeInterval duration = self.animatedDuration;
        if ([view respondsToSelector:@selector(animatedDuration)]) {
            duration = [view animatedDuration];
        }
        
        switch (type) {
            case FXViewPushTypeAlert:{
                [[FXAnimateContext sharedInstance] cancelAlert:view Duration:duration Block:^(BOOL success){
                    [view.superview removeFromSuperview];
                }];
                break;
            }
            case FXViewPushTypeLeft:{
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:-[view viewSize].width Block:^(BOOL success){
                    [view.superview removeFromSuperview];
                }];
                break;
            }
            case FXViewPushTypeRight:{
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:[view viewSize].width Block:^(BOOL success){
                    [view.superview removeFromSuperview];
                }];
                break;
            }
            case FXViewPushTypeTop:{
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:-[view viewSize].height Block:^(BOOL success){
                    [view.superview removeFromSuperview];
                }];
                break;
            }
            case FXViewPushTypeBottom:{
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:[view viewSize].height Block:^(BOOL success){
                    [view.superview removeFromSuperview];
                }];
                break;
            }
            default:
                break;
        }
    }
}

@end
