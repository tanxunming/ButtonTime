//
//  UIButton+ButtonTime.m
//  iOS-timer
//
//  Created by xunmingtan on 2019/3/7.
//  Copyright © 2019 xunmingtan. All rights reserved.
//

#import "UIButton+ButtonTime.h"

@implementation UIButton (ButtonTime)

-(void)setWithBtnTotal:(NSInteger)btnTotal btnTitle:(NSString *)btnTitle btnText:(NSString *)btnText btnmColor:(UIColor *)btnmColor btncolor:(UIColor *)btncolor
{
    if (btnTotal>0) {
        
        return;
    }
    
     __block NSInteger btnTotals = btnTotal;
    
    // GCD定时器   dispatch_queue_create 创建队列
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        
        if (btnTotal <= 0) {//倒计时结束
            
            //关闭定时器
            dispatch_source_cancel(timer);//需要注意的是没写这个方法  dispatch_source_set_event_handler里面不会走
            
            //主线程回到按钮状态
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setTitle:@"60秒" forState:UIControlStateNormal];
                
                self.userInteractionEnabled=YES;
                
            });
            
        }else{//继续倒计时
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                int seconds = btnTotals % 60;
                
                NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
                
                [self setTitle:timeStr forState:UIControlStateNormal];
                
                [self setBackgroundColor:[UIColor cyanColor]];
                
                self.userInteractionEnabled=NO;
                
            });
            
            btnTotals--;
            
        }
        
    });
    
    // 开启定时器
    dispatch_resume(timer);
    
}


@end
