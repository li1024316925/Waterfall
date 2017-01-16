//
//  SecondCollectionReusableView.m
//  瀑布流Test
//
//  Created by LLQ on 17/1/13.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import "SecondCollectionReusableView.h"

@implementation SecondCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, self.bounds.size.height)];
        _textLable.font = [UIFont systemFontOfSize:20];
        [self addSubview:_textLable];
    }
    return self;
}

@end
