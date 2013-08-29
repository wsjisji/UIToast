//
//  UIToast.m
//  remote
//
//  Created by chen on 13-8-26.
//
//

#import "UIToast.h"
#import "UIRotateViewController.h"

@implementation UIToast

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}


- (void)showToast:(NSString*)text tiemInterval:(float)time
{
    [self showToast:text tiemInterval:time backGroundRes:nil];
}

- (void)showToast:(NSString*)text tiemInterval:(float)time backGroundRes:(NSString*)bgResPath
{
    if (nil == text || time <= 0)
        return;
    
    if (time < 2)
        time = 2;
    
    
    UIRotateViewController *controller = [[UIRotateViewController alloc] init];
    [controller setShowText:text andBgResPath:bgResPath];
    [[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] addSubview:controller.view];
    controller.view.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        controller.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (time - 1) * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.5 animations:^{
                controller.view.alpha = 0;
            } completion:^(BOOL finished) {
                [controller.view removeFromSuperview];
                [controller release];
            }];
        });
    }];
}

@end
