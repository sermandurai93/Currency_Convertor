//
//  CCBaseModel.h
//  Currency_Convertor
//
//  Created by Sermandurai Subbiah on 19/07/18.
//  Copyright © 2018 Sermandurai Subbiah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCBaseModel : NSObject

@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSDictionary *rates;
@property (nonatomic, strong) NSString *lastUpdateTimestamp;

@end
