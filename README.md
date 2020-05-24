# MacOS Exporter

This repo contains a general configuration and installation script for
NodeExporter on MacOS. Currently working on my Mac Book Pro running MacOS High
Sierra 10.13.6. 

NodeExporter provides the most basic metrics of the node (the host system) over
a compatible Prometheus HTTP API. NodeExporter has the reserved port of 9100 and
by default provides uses the path `/metrics`. NodeExporter is compatible with
MacOS (obviously) but only provides a subset of the full metrics available on
Linux. All the MacOS metrics modules are enabled by default.

Extra node metrics are provided by the iStats Ruby gem and the IntelPowerGadget
app. The iStats gem install system wide as root and provides a terminal command
to display various sensor information. The IntelPowerGadget is a MacOS app which
provides a C language Framework library. This repo contains a C file and
compilation target in the Makefile to fetch more metrics and output them in a
format compatible with NodeExporter. These extra metrics are written to a
directory monitored by NodeExporter.

All three apps (NodeExporter and the extra metrics script) are added as system
wide LaunchAgent services configured to be run as root. All persisted data is
stored in the `/tmp` dir.

I urge any one to inspect the Makefile and not to trust it blindly. If for no
other reason than to see how straightforward it is and diagnose any errors that
might occur.

## Install dependencies

This will brew install the node_exporter packages and brew cask install the
intel power gadget. It will also gem install iStats. Obviously you have to have
the Homebrew package manager already installed.

```
make install_deps
```

## Install executables and config files

This will copy a bunch of files below `/usr/local` and 2 plist files into
`/Library/LaunchAgents/`.

```
make install
```

This command is safe to run repeatedly if/when the configurations have been
customized. Only changes to the plist files need reloading any other changes
should be picked straightaway.

## Load the services

This will actually load and start the services.

```
make load
```

Now check the `/tmp` dir for files.

## Stop, start and unload

Manages the services.

```
make (stop|start|unload)
```

## Uninstall

This removes all the files added by install and cleans up the tmp dir as well.

## Build intel_sensors

The intel_sensors command is compiled as part of the install target but this can
be run separately too.

```
make intel_sensors
```

## Play

The node exporter should be available at

```
http://localhost:9100
```

## Customization

The sensors.sh script is contains some basic common sensors. You might want to
configure it for your system. Use the output of istat scan to add or remove your
own systems sensors.
