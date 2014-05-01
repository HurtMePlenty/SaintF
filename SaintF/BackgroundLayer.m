//
//  BackgroundLayer.m
//  SaintF
//
//  Created by Alexey Semenov on 29/04/14.
//  Copyright 2014 Eliphas. All rights reserved.
//

#import "BackgroundLayer.h"

static BackgroundLayer* _sharedBGLayer;

@interface BackgroundLayer(){
    CCSprite* staticBackground;
    NSMutableDictionary* bgResources;
    NSMutableArray* bgObjects;
    
    float winWidth;
}

@end

@implementation BackgroundLayer

-(id)init {
    if(self = [super init]) {
        self.color = ccc3(220, 220, 255);
        self.opacity = 255;
        winWidth = [[CCDirector sharedDirector] winSize].width;
    }
    return self;
}

-(void) buildInitialBackground {
    for(int i =0; i < 5; i++)
    {
        
    }

}

-(void) scrollBackgroundFor:(float)length {
    CCSprite* lastObject = [bgObjects lastObject];
    BackgroundObjects lastTag;
    if(lastObject) {
        lastTag = [lastObject tag];
    }
    
}

-(void) tryToGenerateNewObj {
    CCSprite* lastObject = [bgObjects lastObject];
    float distFromLast = winWidth - lastObject.position.x;
    if([self shouldGenerateNewObj:distFromLast])
    {
        [self generateNewObj];
    }
}

-(bool) shouldGenerateNewObj:(float)distFromLast {
    if(distFromLast < 150 && (int)distFromLast % 30 != 0) { //try to generate only each next 30 point
        return false;
    }
    
    int addChance = distFromLast / 100;
    int chanceToGen = arc4random() % 4;
    chanceToGen += addChance;
    if(chanceToGen > 3) {
        return true;
    }
    return false;
    
}

-(void) generateNewObj {
    int type = arc4random() % 5;
    
    CCSprite* newObj;
    
    for(int i = 0; i< bgObjects.count; i++){
        CCSprite* bgObj = [bgObjects objectAtIndex:i];
        if(bgObj.tag == type && !bgObj.visible)
        {
            newObj = bgObj;
        }
    }
    if(!newObj){
        NSString *objFileName = [bgResources objectForKey:[NSNumber numberWithInt:type]];
        newObj = [CCSprite spriteWithSpriteFrameName:objFileName];
        newObj.tag = type;
        [self addChild:newObj];
        [bgObjects addObject:newObj];
    }
    newObj.position = ccp(winWidth, 0);
    newObj.visible = true;
}




-(void) buildObjectResourceDict {
    bgResources = [[NSMutableDictionary alloc] init];
    [bgResources setObject:@"bush.png" forKey:[NSNumber numberWithInt:bush]];
    [bgResources setObject:@"klen.png" forKey:[NSNumber numberWithInt:klen]];
    [bgResources setObject:@"oak.png" forKey:[NSNumber numberWithInt:oak]];
    [bgResources setObject:@"platan.png" forKey:[NSNumber numberWithInt:platan]];
    [bgResources setObject:@"yasen.png" forKey:[NSNumber numberWithInt:yasen]];
    bgObjects = [[NSMutableArray alloc] init];
}


+(BackgroundLayer*) sharedBGLayer {
    if(!_sharedBGLayer)
    {
        _sharedBGLayer = [[BackgroundLayer alloc] init];
    }
    return _sharedBGLayer;
}

@end
