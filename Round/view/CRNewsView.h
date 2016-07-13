//
//  CRNewsView.h
//  SmartAgriculture
//
//  Created by onlyou1991 on 16/6/27.
//  Copyright © 2016年 LEE . All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRNewsView;
/**
 *  CRNewsViewDelegate
 */
@protocol CRNewsViewDelegate <NSObject>

@optional
/**
 *  点击方法
 */
-(void)cr_newsView:(CRNewsView *)cr_newsView didCRNewsViewAtIndex:(NSUInteger)index;

@end

@interface CRNewsView : UIView

@property(weak,nonatomic) id<CRNewsViewDelegate> delegate;
//图片数组
@property (strong, nonatomic) NSArray *datasourceImages;

@end