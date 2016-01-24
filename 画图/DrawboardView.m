//
//  DrawboardView.m
//  GesturePassWord
//
//  Created by pop on 15/7/31.
//  Copyright (c) 2015年 Lois_soul. All rights reserved.
//

#import "DrawboardView.h"
@interface DrawboardView()
@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, strong) NSMutableArray * colorArray;
@property (nonatomic, strong) NSTimer * timer;
@property BOOL isplay;
@end

@implementation DrawboardView
static int step = 0;
- (NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (NSMutableArray *)colorArray
{
    if (_colorArray == nil) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}

- (UIColor*)drawCollor
{
    if (_drawCollor == nil)
    {
        _drawCollor = [UIColor blackColor];
    }
    return _drawCollor;
}

- (void)clear
{
    [self.paths removeAllObjects];
    [self.colorArray removeAllObjects];
    [self setNeedsDisplay];
}

- (void)back
{
    [self.paths removeLastObject];
    [self.colorArray removeLastObject];
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/**
 确定起点
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获得当前的触摸点
    UITouch *touch = [touches anyObject];
    CGPoint startPos = [touch locationInView:touch.view];
    
    // 2.创建一个新的路径
    UIBezierPath *currenPath = [UIBezierPath bezierPath];
    currenPath.lineCapStyle = kCGLineCapRound;
    currenPath.lineJoinStyle = kCGLineJoinRound;

    // 设置起点
    [currenPath moveToPoint:startPos];
    
    // 3.添加路径到数组中
    [self.paths addObject:currenPath];
    [self.colorArray addObject:[self.drawCollor copy]];
    [self setNeedsDisplay];
    
    NSLog(@"hell world");
}

/**
 连线
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInView:touch.view];
    UIBezierPath *currentPath = [self.paths lastObject];
    [currentPath addLineToPoint:pos];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    if (self.isplay)
    {
        for (int i = 0; i<step; i++)
        {
            UIColor * color = self.colorArray[i];
            [color set];
            UIBezierPath * path = self.paths[i];
            path.lineWidth = 10;
            [path stroke];
        }
        if (step>=self.paths.count)
        {
            [_timer invalidate];
            self.isplay = NO;
            step = 0;
            return;
        }
    }
    else
    {
        for (int i = 0; i<self.paths.count; i++)
        {
            UIColor * color = self.colorArray[i];
            [color set];
            UIBezierPath * path = self.paths[i];
            path.lineWidth = 10;
            [path stroke];
        }
    }
}

- (void)playView
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(playDraw) userInfo:nil repeats:YES];
}


- (void)playDraw
{
    step ++;
    self.isplay = YES;
    [self setNeedsDisplay];
}


@end