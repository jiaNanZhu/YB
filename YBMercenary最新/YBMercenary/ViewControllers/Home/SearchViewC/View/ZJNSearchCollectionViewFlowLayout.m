//
//  ZJNSearchCollectionViewFlowLayout.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/1.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSearchCollectionViewFlowLayout.h"

@implementation ZJNSearchCollectionViewFlowLayout
//让item居左
- (void)prepareLayout{
    [super prepareLayout];
    
    self.minimumLineSpacing = AdFloat(24);
    self.minimumInteritemSpacing = AdFloat(40);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(AdFloat(30), AdFloat(30), AdFloat(60), AdFloat(30));
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.alwaysBounceVertical = YES;
}
//定义屏幕展示的范围和数量
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *answer = [super layoutAttributesForElementsInRect:rect];
    // 遍历结果
    for(int i = 1; i < [answer count]; ++i) {
        // 获取cell的Attribute，根据上一个cell获取最大的x，定义为origin
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
        NSInteger origin;
        if (currentLayoutAttributes.indexPath.section != prevLayoutAttributes.indexPath.section) {
            origin = -AdFloat(10);
        }else{
            origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        }
        // 设置cell最大间距
        NSInteger maximumSpacing = AdFloat(40);
        // 若当前cell和precell在同一行：①判断当前的cell加间距后的最大宽度是否小于ContentSize的宽度，②判断当前cell的x是否大于precell的x（否则cell会出现重叠）
        //满足则给当前cell的frame属性赋值（不满足的cell会根据系统布局换行）
        CGRect frame = currentLayoutAttributes.frame;
        if (origin+maximumSpacing+frame.size.width+AdFloat(30)>[UIScreen mainScreen].bounds.size.width) {
            //
        }else{
            frame.origin.x = origin + maximumSpacing;
        }
        
        currentLayoutAttributes.frame = frame;
    }
    return answer;
}
@end
