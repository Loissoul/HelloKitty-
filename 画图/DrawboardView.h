//
//  DrawboardView.h
//  GesturePassWord
//
//  Created by pop on 15/7/31.
//  Copyright (c) 2015年 Lois_soul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawboardView : UIView
@property (nonatomic,strong) UIColor *drawCollor;
- (void)clear;
- (void)playView;
- (void)back;
@end
