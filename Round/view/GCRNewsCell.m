//
//  GCRNewsCell.m
//  SmartAgriculture
//
//  Created by onlyou1991 on 16/6/24.
//  Copyright © 2016年 LEE . All rights reserved.
//

#import "GCRNewsCell.h"


@implementation GCRNewsCell
- (void)awakeFromNib
{
    self.iconImage.clipsToBounds = YES;
}
-(void)setNews:(News *)news{
    _news = news;
    self.iconImage.image = [UIImage imageNamed:news.picture];
    self.title.text =  news.title;
}

@end
