//
//  Life.m
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/7/14.
//
//

#import "Life.h"

@implementation Life

CCDirector *director;


-(id) init{
    director = [CCDirector sharedDirector];
    self.sprite = [CCSprite spriteWithFile:@"heart.png"];//load heart from file
    while (self.sprite.position.y < 20){
    self.sprite.position = CGPointMake((int)director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height*0.77 + (int)director.screenSize.height*0.1);
    }
    
    self.sprite.scale = 0.23f;
    self.speed = -4;
    return self;
}

-(void) update{
    //NSLog(@"life var updated");
    //if (self.sprite.position.x < 0){
        //[self reset];
    //}
    if(CGRectIntersectsRect([self.sprite boundingBox], [self.ship boundingBox])){
        
    }
    self.sprite.position = CGPointMake(self.sprite.position.x + self.speed,
                                       self.sprite.position.y);
}


-(void) reset{
    self.sprite.position = CGPointMake(director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height*0.77 + (int)director.screenSize.height*0.1);
}

-(void) replay{
    self.speed = -4;
}

-(void) pause{
    // tempSpeed = self.speed;
    self.speed = 0;
}

@end