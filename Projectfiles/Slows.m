//
//  Slows.m
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/27/14.
//
//

#import "Slows.h"

@implementation Slows

CCDirector *director;


-(id) init{
    director = [CCDirector sharedDirector];
    self.sprite = [CCSprite spriteWithFile:@"slow.png"];//load slow from file
    while (self.sprite.position.y < 20){
        self.sprite.position = CGPointMake((int)director.screenSize.width,
                                           arc4random() % (int)director.screenSize.height);
    }
    
    self.sprite.scale = 0.4f;
    self.speed = -4;
    return self;
}

-(void) update{
    self.sprite.position = CGPointMake(self.sprite.position.x + self.speed,
                                       self.sprite.position.y);
}

-(void) reset{
    self.sprite.position = CGPointMake(director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height);
}

-(void) replay{
    self.speed = -4;
}

-(void) pause{
    self.speed = 0;
}

@end
