#import "Soomla.h"
#import "UnityCommons.h"
#import "Reward.h"
#import "SequenceReward.h"
#import "RewardStorage.h"
#import "SoomlaUtils.h"
#import "UnitySoomlaCoreEventDispatcher.h"
#import "SoomlaConfig.h"

extern "C" {
    void soomlaCore_Init(const char* secret, bool debug) {
        LogDebug(@"SOOMLA Unity UnitySoomlaCore", @"Initializing SoomlaEventHandler ...");
        
        DEBUG_LOG = debug;
        [UnitySoomlaCoreEventDispatcher initialize];
        [Soomla initializeWithSecret:[NSString stringWithUTF8String:secret]];
    }

    long rewardStorage_GetLastGivenTimeMillis(const char* sRewardJson) {
        Reward* reward = nil;
        if(sRewardJson) {
            NSString* rewardJson = [NSString stringWithUTF8String:sRewardJson];
            reward = [Reward fromDictionary:[SoomlaUtils jsonStringToDict:rewardJson]];
        }
        
        return [RewardStorage getLastGivenTimeMillisForReward:reward];
    }
    
    int rewardStorage_GetTimesGiven(const char* sRewardJson) {
        Reward* reward = nil;
        if(sRewardJson) {
            NSString* rewardJson = [NSString stringWithUTF8String:sRewardJson];
            reward = [Reward fromDictionary:[SoomlaUtils jsonStringToDict:rewardJson]];
        }
        
        return [RewardStorage getTimesGivenForReward:reward];
    }
    
    void rewardStorage_SetTimesGiven(const char* sRewardJson, bool up, bool notify) {
        Reward* reward = nil;
        if(sRewardJson) {
            NSString* rewardJson = [NSString stringWithUTF8String:sRewardJson];
            reward = [Reward fromDictionary:[SoomlaUtils jsonStringToDict:rewardJson]];
        }
        
        [RewardStorage setTimesGivenForReward:reward up:up andNotify:notify];
    }

    int rewardStorage_GetLastSeqIdxGiven(const char* sSeqRewardJson) {
        SequenceReward* seqReward = nil;
        if(sSeqRewardJson) {
            NSString* seqRewardJson = [NSString stringWithUTF8String:sSeqRewardJson];
            seqReward = (SequenceReward*)[Reward fromDictionary:[SoomlaUtils jsonStringToDict:seqRewardJson]];
        }
        
        return [RewardStorage getLastSeqIdxGivenForReward:seqReward];
    }

    void rewardStorage_SetLastSeqIdxGiven(const char* sSeqRewardJson, int idx) {
        SequenceReward* seqReward = nil;
        if(sSeqRewardJson) {
            NSString* seqRewardJson = [NSString stringWithUTF8String:sSeqRewardJson];
            seqReward = (SequenceReward*)[Reward fromDictionary:[SoomlaUtils jsonStringToDict:seqRewardJson]];
        }
        
        return [RewardStorage setLastSeqIdxGiven:idx ForReward:seqReward];
    }    
}