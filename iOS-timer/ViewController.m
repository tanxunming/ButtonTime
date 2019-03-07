//
//  ViewController.m
//  iOS-timer
//
//  Created by xunmingtan on 2019/3/6.
//  Copyright © 2019 xunmingtan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//@property(nonatomic,strong)NSTimer *timer;


// 计时时间
@property (nonatomic, assign) int timeout;


@property(nonatomic,weak)UIButton *timeBtn;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建NSTimer对象 每秒调用
    /*
     
     self.timer= [NSTimer timerWithTimeInterval:1 target:self selector:@selector(time) userInfo:nil repeats:YES];
     
     //    定时器在 UIScrollView 拖动时也不影响的话
     //    timer分别添加到 UITrackingRunLoopMode 和 NSDefaultRunLoopMode中
     [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
     [[NSRunLoop mainRunLoop] addTimer:timer forMode: UITrackingRunLoopMode];
     [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
     */
    
    //延时GCD
    /*
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
     NSLog(@"===%@",[NSThread currentThread]);
     
     [self time];
     
     });
     */
    
    UIButton * countDownBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 150, 120, 40)];
    [countDownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    countDownBtn.backgroundColor = [UIColor redColor];
    [countDownBtn addTarget:self action:@selector(startCountdown) forControlEvents:UIControlEventTouchUpInside];
    self.timeBtn=countDownBtn;
    [self.view addSubview:countDownBtn];
    
 
}


/** 开启倒计时 */
- (void)startCountdown
{
    
    if (self.timeout>0) {

        return;
    }

     self.timeout=10;

    // GCD定时器   dispatch_queue_create 创建队列
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
    
        if (self.timeout <= 0) {//倒计时结束

            //关闭定时器
            dispatch_source_cancel(timer);//需要注意的是没写这个方法  dispatch_source_set_event_handler里面不会走
 
            //主线程回到按钮状态
            dispatch_async(dispatch_get_main_queue(), ^{

                [self.timeBtn setTitle:@"60秒" forState:UIControlStateNormal];
                
                [self.timeBtn setBackgroundColor:[UIColor redColor]];
                
                self.timeBtn.userInteractionEnabled=YES;

            });

        }else{//继续倒计时

            dispatch_async(dispatch_get_main_queue(), ^{

                [self.timeBtn setTitle:[NSString stringWithFormat:@"%.2d秒", self.timeout] forState:UIControlStateNormal];

                [self.timeBtn setBackgroundColor:[UIColor cyanColor]];
                
                self.timeBtn.userInteractionEnabled=NO;
                
            });

            self.timeout--;

        }
        
    });
    
    // 开启定时器
    dispatch_resume(timer);

}




/**
 *  定时器
 */
-(void)time
{
    
    static int i = 0;
    i++;
    
    
    NSLog(@"NSTimer: %d",i);

}


@end
