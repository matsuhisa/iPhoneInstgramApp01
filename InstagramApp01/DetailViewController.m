//  DetailViewController.m
//  InstagramApp01

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setPhoto:(id)newPhoto
{
    if (_photo != newPhoto) {
        _photo = newPhoto;
        [self configureView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)configureView
{
    // ユーザー名
    NSString *username = self.photo[@"user"][@"full_name"];
    self.username.text = username;
    
    // Like
    NSNumber *likecount = self.photo[@"likes"][@"count"];
    self.likeCount.text = [likecount stringValue];;

    // 画像取得
    NSURL *image_url = [NSURL URLWithString:self.photo[@"images"][@"standard_resolution"][@"url"]];
    NSURL *user_url  = [NSURL URLWithString:self.photo[@"user"][@"profile_picture"]];
    
    // セッションを用意する
    // - タイムアウトの時間などを設定可能らしい
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    // タスクの設定をする
    NSURLSessionDataTask* task =
    [session dataTaskWithURL:image_url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               UIImage* image = [UIImage imageWithData:data];

               _instagramImage.contentMode = UIViewContentModeScaleAspectFit;

               // UIImageVIewを更新する
               dispatch_async(dispatch_get_main_queue(), ^{
                   _instagramImage.image = image;
               });
           }];

    // ユーザープロフィールの写真
    NSURLSessionDataTask* usertask =
    [session dataTaskWithURL:user_url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               UIImage* image = [UIImage imageWithData:data];
               
               _userphoto.contentMode = UIViewContentModeScaleAspectFit;
               
               // UIImageVIewを更新する
               dispatch_async(dispatch_get_main_queue(), ^{
                   _userphoto.image = image;
               });
           }];
    
    
    [task resume];
    [usertask resume];
}

@end
