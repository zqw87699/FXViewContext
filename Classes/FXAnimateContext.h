//
//  FXAnimateContext.h
//  TTTT
//
//  Created by 张大宗 on 2017/4/11.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FXSingleton.h"
#import "IFXViewShowProtocol.h"

@interface FXAnimateContext : NSObject

AS_SINGLETON(FXAnimateContext)

- (void)shakeView:(UIView*)view Block:(void(^)(BOOL success))block;

- (void)alertView:(UIView*)view Duration:(CGFloat)duration Block:(void(^)(BOOL success))block;

- (void)cancelAlert:(UIView*)view Duration:(CGFloat)duration Block:(void(^)(BOOL success))block;

- (void)horizontalMove:(UIView*)view Duration:(CGFloat)duration Distance:(CGFloat)dis Block:(void(^)(BOOL success))block;

- (void)verticalMove:(UIView*)view Duration:(CGFloat)duration Distance:(CGFloat)dis Block:(void(^)(BOOL success))block;

@end
