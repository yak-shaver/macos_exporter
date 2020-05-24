#!/bin/sh
mkdir -p /tmp/node_exporter
prom=/tmp/node_exporter/collector.prom
/usr/local/bin/sensors.sh > $prom.$
/usr/local/bin/intel_sensors >> $prom.$
/usr/local/bin/smartmon.sh >> $prom.$
mv $prom.$ $prom
