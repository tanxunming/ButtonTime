//
//  UIButton+ButtonTime.h
//  iOS-timer
//
//  Created by xunmingtan on 2019/3/7.
//  Copyright © 2019 xunmingtan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ButtonTime)



/**
 *    倒计时按钮
 *    @param btnTotal  倒计时总时间
 *    @param btnTitle  还没倒计时的title
 *    @param btnText   倒计时的子名字 如：时、分
 *    @param btnmColor    还没倒计时的颜色
 *    @param btncolor     倒计时的颜色
 */

-(void)setWithBtnTotal:(NSInteger)btnTotal btnTitle:(NSString *)btnTitle btnText:(NSString *)btnText btnmColor:(UIColor *)btnmColor btncolor:(UIColor *)btncolor;



@end

NS_ASSUME_NONNULL_END
