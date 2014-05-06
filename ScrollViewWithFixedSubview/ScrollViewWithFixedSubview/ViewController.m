//
//  ViewController.m
//  ScrollViewWithFixedSubview
//
//  Created by Jowyer on 14-5-6.
//
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController
{
    UIView *floatingBarView;
    CGFloat lastOffset;
    CGFloat kFloatingBarDefaultY;
    CGFloat kFloatingBarLimitY;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(320, 1200);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testImage.jpg"]];
    imageView.frame = CGRectMake(0, 0, 320, 600);
    imageView.contentMode = UIViewContentModeTop;
    [self.scrollView addSubview:imageView];
    
    kFloatingBarLimitY = 40;
    kFloatingBarDefaultY = 140;
    floatingBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kFloatingBarDefaultY, 320, 70)];
    floatingBarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:floatingBarView];
}

#pragma mark- ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView)
    {
        CGFloat offsetChange = lastOffset - scrollView.contentOffset.y;
        lastOffset = scrollView.contentOffset.y;
        
        CGRect f = floatingBarView.frame;
        f.origin.y += offsetChange;
        NSLog(@"%f, %f, %f", scrollView.contentOffset.y, offsetChange, f.origin.y);
        if (offsetChange < 0)
        {
            // scroll up
            if (f.origin.y < kFloatingBarLimitY)
                f.origin.y = kFloatingBarLimitY;
        }
        else
        {
            // scroll down
            if (scrollView.contentOffset.y > kFloatingBarDefaultY - kFloatingBarLimitY)
            {
                f.origin.y = kFloatingBarLimitY;
            }
        }
        
        /*
        if (scrollView.contentOffset.y <= 0)
        {
            f.origin.y = kFloatingBarDefaultY;
        }
        */
       
        if (scrollView.contentOffset.y + scrollView.bounds.size.height >= scrollView.contentSize.height)
        {
            NSLog(@"show bottom");
            f.origin.y = kFloatingBarLimitY;
        }
        
        
        floatingBarView.frame = f;
    }
}

// TODO: 1. floatingBarView scrollable
// 2. scroll too quick will leave offset
// http://pastie.org/pastes/4656778

@end
