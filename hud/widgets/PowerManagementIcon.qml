pragma ComponentBehavior: Bound

import Quickshell.Services.UPower
import qs.components
import qs.config.tokens.feature

MaterialIcon {
    id: root

    property PowerManagementIcon theme

    animate: true
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
            root.theme.colors.content;
        } else if (UPower.displayDevice.percentage > 0.2) {
            root.theme.colors.content;
        } else if (UPower.displayDevice.percentage > 0.1) {
            root.theme.warningColors.content;
        } else {
            root.theme.criticalColors.content;
        }
    }
    fill: 1
}
