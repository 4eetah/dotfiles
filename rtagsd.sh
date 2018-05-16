#!/sbin/openrc-run
# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

start() {
	echo "Start rdm"
	rdm &
}

stop() {
	pkill -9 rdm
	echo "Stop rdm"
}
