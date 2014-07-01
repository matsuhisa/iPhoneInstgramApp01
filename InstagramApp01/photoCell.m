//  photoCell.m
//  InstagramApp01

#import "photoCell.h"

@interface photoCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *titleBackground;
@end

@implementation photoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.titleLabel.text = _title;
}

- (void)setUrl:(NSString *)url
{
    _url = [url copy];
    
    // 文字の下の画像を用意しておく
    UIImage *image = [UIImage imageNamed:@"image.png"];
    self.titleBackground.image = image;
    
    // 画像取得
    NSURL *image_url = [NSURL URLWithString:self.url];

    // セッションを用意する
    // - タイムアウトの時間などを設定可能らしい
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    // タスクの設定をする
    NSURLSessionDataTask* task =
    [session dataTaskWithURL:image_url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               
               // オリジナル画像
               UIImage* image = [UIImage imageWithData:data];
               
               // 切り抜き？
               NSLog(@"------------");
               NSLog(@"%d", image.size.width);
               NSLog(@"%d", image.size.height);
               NSLog(@"------------");
               
               CGRect trimArea = CGRectMake(0, 0, 640, 400);
               
               CGImageRef srcImageRef = [image CGImage];
               CGImageRef trimmedImageRef = CGImageCreateWithImageInRect(srcImageRef, trimArea);
               UIImage *createdImage = [UIImage imageWithCGImage:trimmedImageRef];

               //_cellPhoto.contentMode = UIViewContentModeScaleAspectFit;
               
               // UIImageVIewを更新する
               dispatch_async(dispatch_get_main_queue(), ^{
                   _cellPhoto.image = createdImage;
               });
           }];

    [task resume];
}

@end
