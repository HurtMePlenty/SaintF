//
//  AnimationHelper.m
//  SaintF
//
//  Created by Alexey Semenov on 26/04/14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import "AnimationHelper.h"


@implementation CCAnimation (Helper)

+(CCAnimation*) animationWithFrame:(NSString*)frame startFrameIndex:(int)startIndex frameCount:(int)frameCount delay:(float)delay {
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    for (int i = startIndex; i < startIndex + frameCount; i++)
    {
        NSString* file = [NSString stringWithFormat:@"%@%i.png", frame, i];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
        [frames addObject:frame];
    }
    // Return an animation object from all the sprite animation frames
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

@end


@implementation AnimationHelper

@end
