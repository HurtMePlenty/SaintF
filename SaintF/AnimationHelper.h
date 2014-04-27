//
//  AnimationHelper.h
//  SaintF
//
//  Created by Alexey Semenov on 26/04/14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCAnimation (Helper)

+(CCAnimation*) animationWithFrame:(NSString*)frame startFrameIndex:(int)startIndex frameCount:(int)frameCount delay:(float)delay;

@end

@interface AnimationHelper : NSObject

@end
