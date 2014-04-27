//
//  MainGameLayer.m
//  SaintF
//
//  Created by Eliphas on 23.04.14.
//  Copyright 2014 Eliphas. All rights reserved.
//

#import "MainGameLayer.h"
#import "Hero.h"

static MainGameLayer* _sharedMainLayer = nil;

@interface MainGameLayer() {
    Hero* hero;
}

@end



@implementation MainGameLayer
@synthesize commonBatch;
-(id)init {
    if(self = [super init])
    {
        [self createBatches];
    }
    return self;
}

-(void) createBatches {
    commonBatch = [CCSpriteBatchNode batchNodeWithFile:@"atlas-png"];
}

-(void) loadHero {
    hero = [Hero sharedHero];
    [self addChild:hero];
}

+(MainGameLayer*) sharedGameLayer {
    if(!_sharedMainLayer)
    {
        _sharedMainLayer = [[MainGameLayer alloc] init];
    }
    return _sharedMainLayer;
}

+(CCSpriteBatchNode*)commonBatch {
    return [_sharedMainLayer commonBatch];
}

@end
