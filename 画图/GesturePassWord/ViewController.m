//
//  ViewController.m
//  GesturePassWord
//
//  Created by Lois_soul on 15/6/23.
//  Copyright (c) 2015年 Lois_soul. All rights reserved.
//

#import "ViewController.h"
#import "kittyView.h"
#import "DrawboardView.h"
#import "UIImage+MJ.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    kittyView * drawView;
    
}
@property (nonatomic,strong) NSMutableArray * collorArray;
@property (nonatomic,strong)IBOutlet DrawboardView * drawboard;
@property (nonatomic,strong)IBOutlet UICollectionView * collectionView;
@end

@implementation ViewController
@synthesize buttonArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collorArray = [[NSMutableArray alloc] initWithArray:@[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor cyanColor],[UIColor yellowColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor],[UIColor brownColor],[UIColor darkGrayColor],[UIColor lightGrayColor],[UIColor blackColor]]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ID"];
}

- (IBAction)clearView:(id)sender
{
    [self.drawboard clear];
}
- (IBAction)playView:(id)sender
{
    [self.drawboard playView];
}
- (IBAction)goBack:(id)sender
{
    [self.drawboard back];
}

- (IBAction)saveImage:(id)sender
{
    // 1.截图
    UIImage *image = [UIImage captureWithView:self.drawboard];
    
    // 2.保存到图片
     UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/**
 保存图片操作之后就会调用
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    { // 保存失败
        NSLog(@"保存失败");
    }
    else
    { // 保存成功
        NSLog(@"sucess");
    }
}

- (IBAction)watchCat:(id)sender
{
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, self.view.frame.size.height-50, 50, 40);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(endView:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    drawView = [[kittyView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    drawView.center = view.center;
    [view addSubview:drawView];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    cell.backgroundColor = self.collorArray[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collorArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor * color = self.collorArray[indexPath.row];
    self.drawboard.drawCollor = color;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endView:(UIButton*)button
{
    [drawView endtime];
    [button.superview removeFromSuperview];
}

@end