//
//  UIRotateViewController.h
//  remote
//
//  Created by chen on 13-8-26.
//
//

#import <UIKit/UIKit.h>

@interface UIRotateViewController : UIViewController
{
    UILabel* _label;
    NSString* _text;
    NSString* _bgRes;
}

- (void)setShowText:(NSString*)text andBgResPath:(NSString*)bgResPath;

@end
