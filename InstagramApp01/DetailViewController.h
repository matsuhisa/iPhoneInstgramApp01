//  DetailViewController.h
//  InstagramApp01

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIImageView *instagramImage;
@property (strong, nonatomic) NSDictionary *photo;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *userphoto;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;

//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
