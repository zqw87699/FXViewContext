//
//  FXAnimateContext.m
//  TTTT
//
//  Created by 张大宗 on 2017/4/11.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "FXAnimateContext.h"

@implementation FXAnimateContext

DEF_SINGLETON(FXAnimateContext)

- (void)shakeView:(UIView *)view Block:(void (^)(BOOL))block{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-5];
    shake.toValue = [NSNumber numberWithFloat:5];
    shake.duration = 0.1;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 2;//次数
    [view.layer addAnimation:shake forKey:@"shakeAnimation"];
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
    } completion:block];
}

- (void)alertView:(UIView *)view Duration:(CGFloat)duration Block:(void (^)(BOOL))block{
    CGAffineTransform origTransform = [view transform];
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1/2.0f animations:^{
            [view setTransform:CGAffineTransformScale(origTransform, 1.2f, 1.2f)];
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0f relativeDuration:1/2.0f animations:^{
            [view setTransform:origTransform];
        }];
    } completion:block];
}

- (void)cancelAlert:(UIView *)view Duration:(CGFloat)duration Block:(void (^)(BOOL))block{
    CGAffineTransform origTransform = [view transform];
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1/4.0f animations:^{
            [view setTransform:CGAffineTransformScale(origTransform, 1.1f, 1.1f)];
        }];
        [UIView addKeyframeWithRelativeStartTime:1/4.0f relativeDuration:3/4.0f animations:^{
            [view setTransform:CGAffineTransformScale(origTransform, 0.8f, 0.8f)];
        }];
        [UIView addKeyframeWithRelativeStartTime:1/4.0f relativeDuration:3/4.0f animations:^{
            [view setAlpha:0.0f];
        }];
        [UIView addKeyframeWithRelativeStartTime:3/4.0f relativeDuration:1/4.0f animations:^{
            [view setAlpha:0.0f];
        }];
    } completion:block];
}

- (void)horizontalMove:(UIView *)view Duration:(CGFloat)duration Distance:(CGFloat)dis Block:(void (^)(BOOL))block{
    [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        CGPoint center = view.center;
        center.x += dis;
        view.center = center;
    } completion: block];
}

- (void)verticalMove:(UIView *)view Duration:(CGFloat)duration Distance:(CGFloat)dis Block:(void (^)(BOOL))block{
    [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        CGPoint center = view.center;
        center.y += dis;
        view.center = center;
    } completion: block];
}



@end
