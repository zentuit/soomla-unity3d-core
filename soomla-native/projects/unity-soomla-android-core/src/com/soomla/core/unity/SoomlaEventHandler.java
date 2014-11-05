package com.soomla.core.unity;

import com.soomla.BusProvider;
import com.soomla.SoomlaUtils;
import com.soomla.events.CustomEvent;
import com.soomla.events.RewardGivenEvent;
import com.soomla.events.RewardTakenEvent;
import com.squareup.otto.Subscribe;
import com.unity3d.player.UnityPlayer;

import org.json.JSONException;
import org.json.JSONObject;

public class SoomlaEventHandler {
    private static SoomlaEventHandler mLocalEventHandler;

    public static void initialize() {
        SoomlaUtils.LogDebug("SOOMLA Unity SoomlaEventHandler", "Initializing SoomlaEventHandler ...");
        mLocalEventHandler = new SoomlaEventHandler();

    }

    public SoomlaEventHandler() {
        BusProvider.getInstance().register(this);
    }

    @Subscribe
    public void onRewardGiven(RewardGivenEvent rewardGivenEvent) {
        UnityPlayer.UnitySendMessage("CoreEvents", "onRewardGiven", rewardGivenEvent.Reward.toJSONObject().toString());
    }

    @Subscribe
    public void onRewardGiven(RewardTakenEvent rewardTakenEvent) {
        UnityPlayer.UnitySendMessage("CoreEvents", "onRewardTaken", rewardTakenEvent.Reward.toJSONObject().toString());
    }

    @Subscribe
    public void onCustom(CustomEvent customEvent) {
        if (customEvent.Sender == this) {
            return;
        }
        try {
            JSONObject eventJSON = new JSONObject();

            eventJSON.put("name", customEvent.getName());

            JSONObject extraJSON = new JSONObject();
            if (customEvent.getExtra() != null) {
                for (String ex : customEvent.getExtra().keySet()) {
                    extraJSON.put(ex, customEvent.getExtra().get(ex));
                }
            }

            eventJSON.put("extra", extraJSON);

            UnityPlayer.UnitySendMessage("CoreEvents", "onCustomEvent", eventJSON.toString());
        } catch (JSONException e) {
            SoomlaUtils.LogError("SOOMLA SoomlaEventHandler", "This is BAD! couldn't create JSON for onMarketItemsRefreshFinished event.");
        }
    }
}
