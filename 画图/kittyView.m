//
//  DrawLineView.m
//  GesturePassWord
//
//  Created by Lois_soul on 15/6/23.
//  Copyright (c) 2015年 Lois_soul. All rights reserved.
//

#import "kittyView.h"

#define Width_Gesture self.frame.size.width
#define Height_Gesture self.frame.size.height

@implementation kittyView
{
    NSTimer * timer;
}
static int step = 0;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changView) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)changView
{
    step ++;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 10);
    [self drawLeftHTJ:context];
    CGContextStrokePath(context);
}



//蝴蝶结中心的圆
- (void)drawRHTJ:(CGContextRef)context
{
    CGContextSetLineWidth(context, 7);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake(195, 47, 45, 45)); //椭圆
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);
    if (step>=4)
    {
        [self leftEar:context];
    }
    
}

//右边的蝴蝶结
- (void)drawRightHTJ:(CGContextRef)context
{
    CGContextSetLineWidth(context, 7);
    CGContextMoveToPoint(context, 238, 55);
    CGContextAddCurveToPoint(context, 330, 30, 250, 170, 221, 94);
    if (step>=3)
    {
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextDrawPath(context, kCGPathFillStroke);
        [self drawRHTJ:context];
    }
    CGContextStrokePath(context);
}

//左边的蝴蝶结
- (void)drawLeftHTJ:(CGContextRef)context
{
    CGContextSetLineWidth(context, 7);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, 216, 45);
    
    CGContextAddCurveToPoint(context, 160, -60, 115, 120, 193, 77);
    if (step>=2)
    {
        [self drawRightHTJ:context];
    }
    if (step>3)
    {
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    CGContextStrokePath(context);
}


//左边三条线
- (void)leftLine:(CGContextRef)context
{
    CGContextSetLineWidth(context, 7);
    CGContextMoveToPoint(context, 55, 145);
    CGContextAddQuadCurveToPoint(context, 22, 143, 5, 147);
    
    CGContextMoveToPoint(context, 58, 170);
    CGContextAddQuadCurveToPoint(context, 40, 170, 20, 178);
    
    CGContextMoveToPoint(context, 71, 188);
    CGContextAddQuadCurveToPoint(context, 45, 198, 28, 211);
    if (step >= 12) {
        [self rightLine:context];
    }
}

//右边三条线
- (void)rightLine:(CGContextRef)context
{
    CGContextMoveToPoint(context, 315, 136);
    CGContextAddQuadCurveToPoint(context, 290, 133, 260, 139);
    
    CGContextMoveToPoint(context, 308, 169);
    CGContextAddQuadCurveToPoint(context, 286, 163, 266, 163);
    
    CGContextMoveToPoint(context, 295, 202);
    CGContextAddQuadCurveToPoint(context, 277, 190, 251, 185);
    CGContextStrokePath(context);
    if (step >= 12) {
        step = 0;
    }
}

//左眼
- (void)lefteye:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake(85, 145, 15, 20)); //椭圆
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);
    if (step >= 9) {
        [self righteye:context];
    }
}

//右眼
- (void)righteye:(CGContextRef)context
{
    CGContextAddEllipseInRect(context, CGRectMake(210, 145, 15, 20)); //椭圆
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);
    if (step >= 10) {
        [self month:context];
    }
}

//嘴巴
- (void)month:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetLineWidth(context, 5);
    CGContextAddEllipseInRect(context, CGRectMake(145, 169, 25, 15)); //椭圆
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);
    if (step >= 11)
    {
        [self leftLine:context];
    }
}

//脸
- (void)face:(CGContextRef)context
{
    CGContextMoveToPoint(context, 273, 102);
    CGContextAddCurveToPoint(context, 297, 172, 276, 230,160, 230);
    CGContextAddCurveToPoint(context, 65, 230, 5, 172,59, 70);
    CGContextSetLineCap(context, kCGLineCapRound);
     CGContextStrokePath(context);
    if (step >= 8)
    {
        [self lefteye:context];
    }
}

//右耳
- (void)rightEar:(CGContextRef)context
{
    
    CGContextMoveToPoint(context, 211, 30);
    CGContextAddQuadCurveToPoint(context, 229, 15, 259, 15);
    CGContextAddQuadCurveToPoint(context, 275, 30, 270, 54);
    if (step >= 7)
    {
        [self face:context];
    }
}
- (void)topEar:(CGContextRef)context
{
    CGContextAddQuadCurveToPoint(context, 132, 30, 156, 32);
    if (step>=6)
    {
        [self rightEar:context];
    }
}
//左耳
- (void)leftEar:(CGContextRef)context
{
    CGContextMoveToPoint(context, 51, 84);
    CGContextAddQuadCurveToPoint(context, 40, 46, 59,20);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextAddQuadCurveToPoint(context, 89, 25, 107, 36);
    if (step>=5)
    {
        [self topEar:context];
    }
}

- (void)endtime
{
    [timer invalidate];
}

@end
