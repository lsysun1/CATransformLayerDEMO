//
//  ViewController.m
//  CAShapeLayerDemo2
//
//  Created by 李松玉 on 15/10/19.
//  Copyright © 2015年 李松玉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic,strong) CALayer *plane1;
@property(nonatomic,strong) CALayer *plane2;
@property(nonatomic,strong) CALayer *container;
@end

@implementation ViewController

#define V_CENTER_X           self.view.center.x
#define V_CENTER_Y           self.view.center.y
#define CG_COLOR(R, G, B, A) [UIColor colorWithRed:(R) green:(G) blue:(B) alpha:(A)].CGColor
#define DEGREE(d)            ((d) * M_PI / 180.0f)




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 普通的一个layer
    self.plane1                  = [CALayer layer];
    self.plane1.anchorPoint      = CGPointMake(0.5, 0.5);                         // 锚点
    self.plane1.frame            = (CGRect){CGPointZero, CGSizeMake(100, 100)};   // 尺寸
    self.plane1.position         = CGPointMake(V_CENTER_X, V_CENTER_Y);           // 位置
    self.plane1.opacity          = 0.6;                                           // 背景透明度
    self.plane1.backgroundColor  = CG_COLOR(1, 0, 0, 1);                          // 背景色
    self.plane1.borderWidth      = 3;                                             // 边框宽度
    self.plane1.borderColor      = CG_COLOR(1, 1, 1, 0.5);                        // 边框颜色(设置了透明度)
    self.plane1.cornerRadius     = 10;                                            // 圆角值
    
    // Z轴平移
    CATransform3D plane1_3D = CATransform3DIdentity;
    plane1_3D               = CATransform3DTranslate(plane1_3D, 0, 0, -10);
    self.plane1.transform        = plane1_3D;
    
    // 普通的一个layer
    self.plane2                  = [CALayer layer];
    self.plane2 .anchorPoint     = CGPointMake(0.5, 0.5);                         // 锚点
    self.plane2 .frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};   // 尺寸
    self.plane2 .position        = CGPointMake(60 + 110, V_CENTER_Y);             // 位置
    self.plane2 .opacity         = 0.6;                                           // 背景透明度
    self.plane2 .backgroundColor = CG_COLOR(0, 1, 0, 1);                          // 背景色
    self.plane2 .borderWidth     = 3;                                             // 边框宽度
    self.plane2 .borderColor     = CG_COLOR(1, 1, 1, 0.5);                        // 边框颜色(设置了透明度)
    self.plane2 .cornerRadius    = 10;                                            // 圆角值
    
    // Z轴平移
    CATransform3D plane2_3D = CATransform3DIdentity;
    plane2_3D               = CATransform3DTranslate(plane2_3D, 0, 0, -30);
    self.plane2.transform        = plane2_3D;
    
    
    
    // 创建容器layer
    self.container = [CALayer layer];
    self.container.frame    = self.view.bounds;
    [self.view.layer addSublayer:self.container];
    
    // 以Y轴为坐标系,旋转45度
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/-500;
    t = CATransform3DRotate(t, DEGREE(45), 0, 1, 0);
    self.container.transform = t;
    
    [self.container addSublayer:self.plane1];
    [self.container addSublayer:self.plane2];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    
    [self.timer fire];
    
    
}

- (void)animation
{
    static float degree = 0.f;
    
    // 起始值
    CATransform3D fromValue = CATransform3DIdentity;
    fromValue.m34           = 1.0/ -500;
    fromValue               = CATransform3DRotate(fromValue, degree, 0, 1, 0);
    
    // 结束值
    CATransform3D toValue   = CATransform3DIdentity;
    toValue.m34             = 1.0/ -500;
    toValue                 = CATransform3DRotate(toValue, degree += 45.f, 0, 1, 0);
    
    // 添加3d动画
    CABasicAnimation *transform3D = [CABasicAnimation animationWithKeyPath:@"transform"];
    transform3D.duration  = 1.f;
    transform3D.fromValue = [NSValue valueWithCATransform3D:fromValue];
    transform3D.toValue   = [NSValue valueWithCATransform3D:toValue];
    self.container.transform = toValue;
    [self.container addAnimation:transform3D forKey:@"transform3D"];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end