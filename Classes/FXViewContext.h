//
//  FXViewContext.h
//  TTTT
//
//  Created by 张大宗 on 2017/4/10.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FXSingleton.h"
#import "IFXViewShowProtocol.h"

@interface FXViewContext : NSObject

AS_SINGLETON(FXViewContext)

- (void)showView:(UIView<IFXViewShowProtocol>*)view Root:(UIView*)root;

- (void)closeView:(UIView<IFXViewShowProtocol>*)view;

@end
