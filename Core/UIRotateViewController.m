//
//  UIRotateViewController.m
//  remote
//
//  Created by chen on 13-8-26.
//
//

#import "UIRotateViewController.h"
#import <QuartzCore/CALayer.h>

@interface UIRotateViewController ()

@end

@implementation UIRotateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initLabel];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)orientationChanged:(NSNotification *)notification
{
    [self setShowText:_text andBgResPath:_bgRes];
}

- (void)dealloc
{
    [super dealloc];
    [self releaseLabel];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initLabel
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [_label setBackgroundColor:[UIColor grayColor]];
    [_label setOpaque:YES];
    [_label setTextColor:[UIColor whiteColor]];
    [_label setTextAlignment:UITextAlignmentCenter];
    [_label setShadowOffset:CGSizeMake(0, 2.0)];
    [_label setFont:[UIFont systemFontOfSize:18.0]];
    _label.layer.cornerRadius = 6;
    _label.layer.masksToBounds = YES;
}

- (void)setShowText:(NSString*)text andBgResPath:(NSString*)bgResPath
{
    [_text release];
    [_bgRes release];
    
    _text = text.copy;
    _bgRes = bgResPath.copy;

    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    int max = MAX(screenWidth, screenHeight);
    int min = MIN(screenWidth, screenHeight);
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        screenHeight = min;
        screenWidth = max;
    }else
    {
        screenHeight = max;
        screenWidth = min;
    }
    
    float maxWidth = 200;
    //高度
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:18.0]];
    int lineNumber = size.width / maxWidth + 1;
    float viewWidth = 1 == lineNumber ? size.width : maxWidth + 10 * lineNumber;
    float viewHeight = lineNumber * size.height;
    [self.view setFrame:CGRectMake((screenWidth - viewWidth) / 2, (screenHeight / 4) * 3 - viewHeight / 2, viewWidth, viewHeight)];
    NSLog(@"self.view = %@", self.view);
    [_label setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    NSLog(@"_label = %@", _label);
    [_label setText:text];
    _label.numberOfLines = lineNumber;
        
    if (nil != bgResPath)
    {
        [_label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:bgResPath]]];
    }
//    [self.view setFrame:CGRectMake(100, 200, 300, 200)];
    [self.view addSubview:_label];
}

- (void)releaseLabel
{
    [_label removeFromSuperview];
    [_label release];
    _label = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (BOOL)shouldAutorotate {
    
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAll;
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self setShowText:_text andBgResPath:_bgRes];
}

@end
