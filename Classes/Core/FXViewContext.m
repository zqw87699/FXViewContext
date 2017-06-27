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
    BOOL touchClose = self.touchClose;
    if ([view respondsToSelector:@selector(hasBackground)]) {
        hasbg = [view hasBackground];
        if ([view respondsToSelector:@selector(backgroundAlpha)]) {
            alpha = [view backgroundAlpha];
        }
        if ([view respondsToSelector:@selector(touchClose)]) {
            touchClose = [view touchClose];
        }
    }
    if (hasbg) {
        UIView *father = [[UIView alloc] init];
        [father setBackgroundColor:[UIColor clearColor]];
        [root addSubview:father];
        [father mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(root);
        }];
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundColor:[UIColor blackColor]];
        [btn setAlpha:alpha];
        [father addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(father);
        }];
        if (touchClose) {
            FX_WEAK_REF_TYPE selfObject = self;
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                [selfObject closeView:view];
            }];
        }
        [father addSubview:view];
        [root layoutIfNeeded];
        return father;
    }else{
        [root addSubview:view];
        return root;
    }
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
                [view setFrame:CGRectMake(view.superview.bounds.size.width/2.0-[view viewSize].width/2.0, view.superview.bounds.size.height/2.0-[view viewSize].height, [view viewSize].width, [view viewSize].height)];
                [[FXAnimateContext sharedInstance] alertView:view Duration:duration Block:nil];
                break;
            }
            case FXViewPushTypeLeft:{
                [view setFrame:CGRectMake(-[view viewSize].width, 0, [view viewSize].width, view.superview.bounds.size.height)];
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:[view viewSize].width Block:nil];
                break;
            }
            case FXViewPushTypeRight:{
                [view setFrame:CGRectMake(view.superview.bounds.size.width, 0, [view viewSize].width, view.superview.bounds.size.height)];
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:-[view viewSize].width Block:nil];
                break;
            }
            case FXViewPushTypeTop:{
                [view setFrame:CGRectMake(0, -[view viewSize].height, view.superview.bounds.size.width, [view viewSize].height)];
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:[view viewSize].height Block:nil];
                break;
            }
            case FXViewPushTypeBottom:{
                [view setFrame:CGRectMake(0, view.superview.bounds.size.height, view.superview.bounds.size.width, [view viewSize].height)];
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:-[view viewSize].height Block:nil];
                break;
            }
            default:
                break;
        }
    }
}

- (void)closeView:(UIView<IFXViewShowProtocol> *)view Block:(SuccessBlock)block{
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
        
        BOOL hasBackground = self.hasBackground;
        if ([view respondsToSelector:@selector(hasBackground)]) {
            hasBackground = [view hasBackground];
        }
        
        switch (type) {
            case FXViewPushTypeAlert:{
                [[FXAnimateContext sharedInstance] cancelAlert:view Duration:duration Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                    if (block) block(success);
                }];
                break;
            }
            case FXViewPushTypeLeft:{
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:-[view viewSize].width Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                    if (block) block(success);
                }];
                break;
            }
            case FXViewPushTypeRight:{
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:[view viewSize].width Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                    if (block) block(success);
                }];
                break;
            }
            case FXViewPushTypeTop:{
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:-[view viewSize].height Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                    if (block) block(success);
                }];
                break;
            }
            case FXViewPushTypeBottom:{
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:[view viewSize].height Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                    if (block) block(success);
                }];
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
        
        BOOL hasBackground = self.hasBackground;
        if ([view respondsToSelector:@selector(hasBackground)]) {
            hasBackground = [view hasBackground];
        }
        
        switch (type) {
            case FXViewPushTypeAlert:{
                [[FXAnimateContext sharedInstance] cancelAlert:view Duration:duration Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                }];
                break;
            }
            case FXViewPushTypeLeft:{
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:-[view viewSize].width Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                }];
                break;
            }
            case FXViewPushTypeRight:{
                [[FXAnimateContext sharedInstance] horizontalMove:view Duration:duration Distance:[view viewSize].width Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                }];
                break;
            }
            case FXViewPushTypeTop:{
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:-[view viewSize].height Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                }];
                break;
            }
            case FXViewPushTypeBottom:{
                [[FXAnimateContext sharedInstance] verticalMove:view Duration:duration Distance:[view viewSize].height Block:^(BOOL success){
                    if (hasBackground) {
                        [view.superview removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                }];
                break;
            }
            default:
                break;
        }
    }
}

@end
