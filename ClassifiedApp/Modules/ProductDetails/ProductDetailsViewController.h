//
//  ProductDetailsViewController.h
//  ClassifiedApp
//
//  Created by Nuzhat Zari on 19/02/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailsViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

-(void)productName: (NSString *)name price:(NSString *)price thumbnails:(NSArray *)thumbnails fullImages:(NSArray *)images;
@end

NS_ASSUME_NONNULL_END
