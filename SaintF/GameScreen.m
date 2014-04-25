//
//  MyCocos2DClass.m
//  SaintF
//
//  Created by Eliphas on 23.04.14.
//  Copyright 2014 Eliphas. All rights reserved.
//

#import "GameScreen.h"
#import "MainGameLayer.h"

@interface GameScreen() {
    
}
@end

@implementation GameScreen

-(id)init{
    if(self = [super init])
    {
        
        [self loadLayers];
    }
    return self;
}

-(void) loadLayers {
    MainGameLayer* mainGameLayer = [MainGameLayer sharedGameLayer];
    [self addChild:mainGameLayer];
}

-(void) loadResources {
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"atlas.plist"];
}

+(CCScene*) scene {
    CCScene* menuScene = [CCScene node];
    GameScreen* menuLayer = [GameScreen node];
    [menuScene addChild:menuLayer];
    return menuScene;
}

@end
