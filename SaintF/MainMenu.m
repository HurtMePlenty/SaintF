//
//  MyCocos2DClass.m
//  SaintF
//
//  Created by Eliphas on 22.04.14.
//  Copyright 2014 Eliphas. All rights reserved.
//

#import "MainMenu.h"
#import "GameScreen.h"

@interface MainMenu(){
    CGSize screenSize;
}
@end

@implementation MainMenu

- (id)init {
    if(self = [super init])
    {
        self.color = ccc3(220, 220, 255);
        self.opacity = 255;
        screenSize = [[CCDirector sharedDirector] winSize];
        [self createMenu];
    }
    return self;
}

+(CCScene*) scene {
    CCScene* menuScene = [CCScene node];
    MainMenu* menuLayer = [MainMenu node];
    [menuScene addChild:menuLayer];
    return menuScene;
}

-(void) createMenu {
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
    [CCMenuItemFont setFontSize:26];
    CCMenuItemFont* playGameItem = [CCMenuItemFont itemWithString:@"Play Game" target:self selector:@selector(playGameHandler:)];
    CCMenuItemFont* options = [CCMenuItemFont itemWithString:@"Options" target:self selector:@selector(optionsHandler:)];
    CCMenu* menu = [CCMenu menuWithItems:playGameItem, options, nil];
    menu.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [menu alignItemsVerticallyWithPadding:40];
    [self addChild:menu];
    
}

-(void) playGameHandler:(id)sender {
    CCLOG(@"play click");
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0 scene:[GameScreen scene]]];
}

@end
