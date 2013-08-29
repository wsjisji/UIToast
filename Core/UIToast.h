//
//  UIToast.h
//  remote
//
//  Created by chen on 13-8-26.
//
//

#import <Foundation/Foundation.h>

@interface UIToast : NSObject
{
}

- (void)showToast:(NSString*)text tiemInterval:(float)time;

- (void)showToast:(NSString*)text tiemInterval:(float)time backGroundRes:(NSString*)bgResPath;

@end
