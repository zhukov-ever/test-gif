//
//  ViewController.m
//  testGif
//
//  Created by Nikita on 28/07/14.
//  Copyright (c) 2014 vigroup. All rights reserved.
//

#import "ViewController.h"
#import <FLAnimatedImage/FLAnimatedImage.h>

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController

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
    // Do any additional setup after loading the view from its nib.
    CGSize _size = [[UIScreen mainScreen] bounds].size;
    UIView* _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _size.width*6, _size.height)];
    
    for (int i = 0; i < 6; i++)
    {
        NSData* _data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"pusheen%@.gif", @(i)] ofType:nil]];
        FLAnimatedImage *_image = [FLAnimatedImage animatedImageWithGIFData:_data];
        FLAnimatedImageView *_imageView = [[FLAnimatedImageView alloc] init];
        _imageView.animatedImage = _image;
        _imageView.frame = CGRectMake(0.0, 0.0, 200, 200);
        [self.view addSubview:_imageView];
       
        
        UIView* _gifView = [[UIView alloc] initWithFrame:CGRectMake(i*_size.width + 60, (_size.height-200) / 2, 200, 200)];
        _gifView.layer.cornerRadius = 100;
        _gifView.clipsToBounds = YES;
        [_gifView addSubview:_imageView];
        
        _gifView.userInteractionEnabled = NO;
        [_contentView addSubview:_gifView];
    }
    
    _contentView.frame = CGRectMake(0, 0, _size.width*6, _size.height);
    [self.scrollView addSubview:_contentView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(_size.width*6, _size.height);
    self.scrollView.delegate = self;
    
    self.pageControl.numberOfPages = 6;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
}


@end
