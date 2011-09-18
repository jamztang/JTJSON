//
//  JTJSON.h
//  JTJSON
//
//  Created by James Tang on 19/09/2011.
//  Copyright 2011 CUHK. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *PListStringAppendMissingSemiColonFromJSONString(NSString *JSONString);
NSString *PListStringFromJSONString(NSString *JSONString);

@interface JTJSON : NSObject

@end
