//  MasterViewController.m
//  InstagramApp01


#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()
@property (strong, nonatomic) NSArray *photos;
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchNewPhotos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)fetchNewPhotos
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/tags/prytty/media/recent?access_token=228314.f59def8.b2923efc7b794cd080eb1ade6a329dd2"];
    
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         if (error)
         {
             // 通信が異常終了したときの処理
             return;
         }
         
         // 通信が正に常終了したときの処理
         NSError *jsonError = nil;
         NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
         
         // JSONエラーチェック
         if (jsonError != nil) return;
         
         // 検索結果をディクショナリにセット
         self.photos = jsonDictionary[@"data"];
         
         // TableView をリロード
         // メインスレッドでやらないと最悪クラッシュする
         [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
     }];
    
    // 通信開始
    [task resume];
}

// テーブルビューを再描画する
- (void)reloadTableView
{
    [self.tableView reloadData];
}


// セルの描画
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *photos = self.photos[indexPath.row];
    
    cell.textLabel.text       = photos[@"caption"][@"text"];
    cell.detailTextLabel.text = photos[@"caption"][@"from"][@"username"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        UITableViewCell *cell = (UITableViewCell *)sender;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary *photo = self.photos[indexPath.row];

        DetailViewController *viewController = [segue destinationViewController];
        viewController.photo = photo;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photos.count;
}

@end
