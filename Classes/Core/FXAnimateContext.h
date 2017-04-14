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

typedef void (^SuccessBlock)(BOOL success);

@interface FXAnimateContext : NSObject

AS_SINGLETON(FXAnimateContext)

- (void)shakeView:(UIView*)view Block:(SuccessBlock)block;

- (void)alertView:(UIView*)view Duration:(CGFloat)duration Block:(SuccessBlock)block;

- (void)cancelAlert:(UIView*)view Duration:(CGFloat)duration Block:(SuccessBlock)block;

- (void)horizontalMove:(UIView*)view Duration:(CGFloat)duration Distance:(CGFloat)dis Block:(SuccessBlock)block;

- (void)verticalMove:(UIView*)view Duration:(CGFloat)duration Distance:(CGFloat)dis Block:(SuccessBlock)block;

- (void)move:(UIView*)view Duration:(CGFloat)duration Point:(CGPoint)point Block:(SuccessBlock)block;

@end
