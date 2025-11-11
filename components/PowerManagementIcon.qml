pragma ComponentBehavior: Bound

import qs.config
import Quickshell.Services.UPower

MaterialIcon {
    id: root

    animate: true
    property ThemeConfig.Widget theme: Config.theme.hud.widgets.powerManagement

    text: {
        if (!UPower.displayDevice.isLaptopBattery) {
            if (PowerProfiles.profile === PowerProfile.PowerSaver) {
                return "energy_savings_leaf";
            }
            if (PowerProfiles.profile === PowerProfile.Performance) {
                return "rocket_launch";
            }
            return "balance";
        }

        if (UPower.displayDevice.percentage === 1) {
            return "battery_android_full";
        }
        const charging = [UPowerDeviceState.Charging, UPowerDeviceState.FullyCharged, UPowerDeviceState.PendingCharge].includes(UPower.displayDevice.state);
        return charging ? "battery_android_bolt" : `battery_android_${Math.floor(UPower.displayDevice.percentage * 7)}`;
    }
    color: {
        if (!UPower.onBattery) {
            root.theme.contentColor;
        } else if (UPower.displayDevice.percentage > 0.2) {
            root.theme.contentColor;
        } else if (UPower.displayDevice.percentage > 0.1) {
            root.theme.warningContentColor;
        } else {
            root.theme.criticalContentColor;
        }
    }
    fill: 1
}
