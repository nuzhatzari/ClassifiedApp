//
//  ProductDetailsViewController.m
//  ClassifiedApp
//
//  Created by Nuzhat Zari on 19/02/21.
//

#import "ProductDetailsViewController.h"
#import "ClassifiedApp-Swift.h"
#import <SDWebImage/SDWebImage.h>

@interface ProductDetailsViewController ()
@property (strong, nonatomic) NSString *prdName;
@property (strong, nonatomic) NSString *prdPrice;
@property (strong, nonatomic) NSArray *thumbnails;
@property (strong, nonatomic) NSArray *images;
@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

-(void)productName: (NSString *)name price:(NSString *)price thumbnails:(NSArray *)thumbnails fullImages:(NSArray *)images {
    _prdName = name;
    _prdPrice = price;
    _thumbnails = thumbnails;
    _images = images;
}

-(void) configureView {
    _lblName.text = _prdName;
    _lblPrice.text = _prdPrice;
    
    CGFloat scrollViewWidth = self.view.frame.size.width;
    CGFloat scrollViewHeight = self.scrollView.frame.size.height;

    for (int index=0; index<_images.count; index++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollViewWidth*index, 0, scrollViewWidth, scrollViewHeight)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:_images[index]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        [_scrollView addSubview:imgView];
    }
    [_scrollView setContentSize:CGSizeMake(scrollViewWidth*_images.count, scrollViewHeight)];
    _scrollView.delegate = self;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _images.count;
    [_pageControl setHidden:_images.count > 1 ? false : true];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    CGFloat currentPage = ((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    _pageControl.currentPage = currentPage;
}

@end
