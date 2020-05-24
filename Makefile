start:
	sudo launchctl start io.prometheus.node_exporter
	sudo launchctl start io.prometheus.collector

stop:
	-sudo launchctl stop io.prometheus.node_exporter
	-sudo launchctl stop io.prometheus.collector

load:
	sudo launchctl load -w /Library/LaunchAgents/io.prometheus.node_exporter.plist
	sudo launchctl load -w /Library/LaunchAgents/io.prometheus.collector.plist

unload:
	-sudo launchctl unload /Library/LaunchAgents/io.prometheus.node_exporter.plist
	-sudo launchctl unload /Library/LaunchAgents/io.prometheus.collector.plist

intel_sensors:
	clang -o intel_sensors -F/System/Library/Frameworks -F/Library/Frameworks -framework IntelPowerGadget intel_sensors.c

.PHONY: clean
clean:
	rm -f intel_sensors

install_deps:
	brew install node_exporter
	brew cask install intel-power-gadget
	brew install smartmontools
	sudo gem install iStats

uninstall_deps:
	brew uninstall node_exporter
	brew cask uninstall intel-power-gadget
	brew cask uninstall smartmontools
	sudo gem uninstall -xa iStats

install: intel_sensors
	sudo cp intel_sensors /usr/local/bin/
	sudo cp sensors.sh /usr/local/bin/
	sudo cp smartmon.sh /usr/local/bin/
	sudo cp collector.sh /usr/local/bin/
	sudo cp node_exporter.args /usr/local/etc/
	sudo cp io.prometheus.node_exporter.plist /Library/LaunchAgents/
	sudo cp io.prometheus.collector.plist /Library/LaunchAgents/
	sudo mkdir -p /tmp/node_exporter
	sudo chmod 1777 /tmp/node_exporter

uninstall:
	sudo rm -f /usr/local/bin/intel_sensors
	sudo rm -f /usr/local/bin/sensors.sh
	sudo rm -f /usr/local/bin/smartmon.sh
	sudo rm -f /usr/local/bin/collector.sh
	sudo rm -f /usr/local/etc/node_exporter.args
	sudo rm -f /Library/LaunchAgents/io.prometheus.node_exporter.plist
	sudo rm -f /Library/LaunchAgents/io.prometheus.collector.plist
	sudo rm -f /tmp/PowerGadgetLog.csv
	sudo rm -f /tmp/node_exporter.log
	sudo rm -f /tmp/collector.log
	sudo rm -rf /tmp/node_exporter/

reset:
	sudo launchctl stop io.prometheus.node_exporter
	sudo launchctl stop io.prometheus.collector
	sudo mkdir -p /tmp/node_exporter
	sudo chmod 1777 /tmp/node_exporter
	sudo launchctl start io.prometheus.node_exporter
	sudo launchctl start io.prometheus.collector
