//
//  GCRNewsCell.h
//  SmartAgriculture
//
//  Created by onlyou1991 on 16/6/24.
//  Copyright © 2016年 LEE . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface GCRNewsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property(nonatomic,strong) News *news;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
