//
//  DCADitem.h
//  Baisibudejie
//
//  Created by 董成 on 2018/12/16.
//  Copyright © 2018 董成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//w_picurl   ori_curl   w    h
@interface DCADitem : NSObject
@property (nonatomic,strong) NSString *ori_curl;
@property (nonatomic,strong) NSString *w_picurl;
@property (nonatomic,assign) CGFloat h;
@property (nonatomic,assign) CGFloat w;
@end
