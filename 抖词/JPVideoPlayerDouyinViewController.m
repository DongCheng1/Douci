

#import "JPVideoPlayerDouyinViewController.h"
#import "JPVideoPlayerKit.h"
#import "UIBarButtonItem+Item.h"

@interface JPDouyinProgressView: JPVideoPlayerProgressView

@end

@implementation JPDouyinProgressView

- (void)layoutThatFits:(CGRect)constrainedRect
nearestViewControllerInViewTree:(UIViewController *_Nullable)nearestViewController
  interfaceOrientation:(JPVideoPlayViewInterfaceOrientation)interfaceOrientation {
    [super layoutThatFits:constrainedRect
nearestViewControllerInViewTree:nearestViewController
     interfaceOrientation:interfaceOrientation];
    
    self.trackProgressView.frame = CGRectMake(0,
                                              constrainedRect.size.height - JPVideoPlayerProgressViewElementHeight - nearestViewController.tabBarController.tabBar.bounds.size.height,
                                              constrainedRect.size.width,
                                              JPVideoPlayerProgressViewElementHeight);
    self.cachedProgressView.frame = self.trackProgressView.bounds;
    self.elapsedProgressView.frame = self.trackProgressView.frame;
}

@end

@interface JPVideoPlayerDouyinViewController()<UIScrollViewDelegate, JPVideoPlayerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *firstImageView;

@property (nonatomic, strong) UIImageView *secondImageView;

@property (nonatomic, strong) UIImageView *thridImageView;

@property (nonatomic, strong) NSArray<NSString *> *douyinVideoStrings;

@property(nonatomic, assign) NSUInteger currentVideoIndex;

@property(nonatomic, assign) CGFloat scrollViewOffsetYOnStartDrag;

@end

@implementation JPVideoPlayerDouyinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setup];
    //设置导航条
    [self setupNavBar];
}

//设置导航条
- (void)setupNavBar {
    self.navigationItem.title = @"抖词短视频";
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentInset = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.scrollViewOffsetYOnStartDrag = -100;
    [self scrollViewDidEndScrolling];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.secondImageView jp_stopPlay];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (decelerate == NO) {
        [self scrollViewDidEndScrolling];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrolling];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.scrollViewOffsetYOnStartDrag = scrollView.contentOffset.y;
}


#pragma mark - JPVideoPlayerDelegate

- (BOOL)shouldShowBlackBackgroundBeforePlaybackStart {
    return YES;
}

#pragma mark - Private

- (void)scrollViewDidEndScrolling {
    if(self.scrollViewOffsetYOnStartDrag == self.scrollView.contentOffset.y){
        return;
    }
    
    CGSize referenceSize = UIScreen.mainScreen.bounds.size;
    [self.scrollView setContentOffset:CGPointMake(0, referenceSize.height) animated:NO];
    [self.secondImageView jp_stopPlay];
    [self.secondImageView jp_playVideoMuteWithURL:[self fetchDouyinURL]
                               bufferingIndicator:nil
                                     progressView:[JPDouyinProgressView new]
                                    configuration:^(UIView *view, JPVideoPlayerModel *playerModel) {
                                        view.jp_muted = NO;
                                    }];
}

- (NSURL *)fetchDouyinURL {
    if(self.currentVideoIndex == (self.douyinVideoStrings.count - 1)){
        self.currentVideoIndex = 0;
    }
    NSURL *url = [NSURL URLWithString:self.douyinVideoStrings[self.currentVideoIndex]];
    self.currentVideoIndex++;
    return url;
}

- (NSArray<NSString *> *)douyinVideoStrings {
    if(!_douyinVideoStrings){
        
        //读取所有数据
        NSURL *url = [NSURL URLWithString:@"http://www.studynumber.com/wordskill/json/videos2.json"];
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        
        _douyinVideoStrings = (NSArray *)jsonObj;
        
    }
    return _douyinVideoStrings;
}


#pragma mark - Setup

- (void)setup {
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize referenceSize = UIScreen.mainScreen.bounds.size;
    self.currentVideoIndex = 0;
    
    self.scrollView = ({
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:scrollView];
        scrollView.frame = self.view.bounds;
        scrollView.contentSize = CGSizeMake(referenceSize.width, referenceSize.height * 3);
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        
        scrollView;
    });
    
    self.firstImageView = ({
        UIImageView *imageView = [UIImageView new];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(0, 0, referenceSize.width, referenceSize.height);
        imageView.image = [UIImage imageNamed:@"placeholder1"];
        
        imageView;
    });
    
    self.secondImageView = ({
        UIImageView *imageView = [UIImageView new];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(0, referenceSize.height, referenceSize.width, referenceSize.height);
        imageView.image = [UIImage imageNamed:@"placeholder2"];
        imageView.jp_videoPlayerDelegate = self;
        
        imageView;
    });
    
    self.thridImageView = ({
        UIImageView *imageView = [UIImageView new];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(0, referenceSize.height * 2, referenceSize.width, referenceSize.height);
        imageView.image = [UIImage imageNamed:@"placeholder1"];
        
        imageView;
    });
}

@end

