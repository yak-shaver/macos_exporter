#!/bin/sh
echo "# HELP node_hwmon_temp_celsius Sensor temperatures"
echo "# TYPE node_hwmon_temp_celsius gauge"
echo "# HELP node_hwmon_speed_rpm Sensor fan speeds"
echo "# TYPE node_hwmon_speed_rpm gauge"
echo "# HELP node_hwmon_power_watts Sensor power consumptions"
echo "# TYPE node_hwmon_power_watts gauge"
echo "# HELP node_hwmon_energy_joules Sensor energies"
echo "# TYPE node_hwmon_energy_joules gauge"
echo "# HELP node_hwmon_frequency_megahertz Sensor frequencies"
echo "# TYPE node_hwmon_frequency_megahertz gauge"

cpu=`/usr/local/bin/istats cpu temp --value-only | xargs`
battery=`/usr/local/bin/istats battery temp --value-only | xargs`
fan1=`/usr/local/bin/istats fan speed --value-only | head -n1 | xargs`

[[ $cpu =~ ^[0-9.]+$ ]] && echo "node_hwmon_temp_celsius{sensor=\"cpu\"} $cpu"
[[ $battery =~ ^[0-9.]+$ ]] && echo "node_hwmon_temp_celsius{sensor=\"battery\"} $battery"
[[ $fan1 =~ ^[0-9.]+$ ]] && echo "node_hwmon_speed_rpm{sensor=\"fan1\"} $fan1"
