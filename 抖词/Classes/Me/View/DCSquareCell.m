//
//  DCSquareCell.m
//  抖词
//
//  Created by 董成 on 2018/12/24.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCSquareCell.h"
#import <UIImageView+WebCache.h>
#import "DCSquareItem.h"

@interface DCSquareCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@end

@implementation DCSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(DCSquareItem *)item {
    _item = item;//将模型上的数据展示到item上
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text = item.name;
}

@end
