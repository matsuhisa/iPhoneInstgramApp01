//  photoCell.h
//  InstagramApp01

#import <UIKit/UIKit.h>

@protocol photoCellDelegate;
@interface photoCell : UITableViewCell

@property (nonatomic, weak) id <photoCellDelegate> delegate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@end

@protocol photoCellDelegate <NSObject>
@end
