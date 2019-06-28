//
//  Utils.m
//  THYG
//
//  Created by Victory on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils

+ (NSString *)md5:(NSString *)inputString
{
	const char *cStr = [inputString UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

+(BOOL)CheckPhoneNum:(NSString *)inputString{
    NSString *Regex =@"^[1][3-8]+\\d{9}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:inputString];
}

+ (BOOL)checkPassword:(NSString *)inputString
{
    NSString *pattern = @"^[a-zA-Z0-9]{6,12}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:inputString];
    return isMatch;
}

+ (void)scheduledCountdown:(void (^)(BOOL, NSTimeInterval, dispatch_source_t))countDown totalTimeInterval:(NSTimeInterval)totalTimeInterval {
    
    __block int timeout = totalTimeInterval;
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //定时循环执行事件
    //dispatch_source_set_timer 方法值得一提的是最后一个参数（leeway），他告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器每5秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每10分钟检查一次，但是不用那么精准。所以你可以传入60，告诉系统60秒的误差是可接受的。他的意义在于降低资源消耗。
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{ //计时器事件处理器
        if (timeout <= 0) {
            dispatch_source_cancel(timer); //取消定时循环计时器；使得句柄被调用，即事件被执行
            dispatch_async(mainQueue, ^{
                BLOCK(countDown,YES,0,timer);
            });
        } else {
            timeout--;
            //NSLog(@"gcd  定时器倒计时: %d",timeout);
            dispatch_async(mainQueue, ^{
                BLOCK(countDown,NO,timeout,timer);
            });
        }
    });
    dispatch_source_set_cancel_handler(timer, ^{ //计时器取消处理器；调用 dispatch_source_cancel 时执行
        NSLog(@"Cancel Handler");
    });
    dispatch_resume(timer);  //恢复定时循环计时器；Dispatch Source 创建完后默认状态是挂起的，需要主动恢复，否则事件不会被传递，也不会被执行
}



@end
