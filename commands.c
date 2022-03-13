// SPDX-FileCopyrightText: 2022 Agathe Porte <microjoe@microjoe.org>
//
// SPDX-License-Identifier: MIT

#include <stdio.h>
#include <stdlib.h>

void ledctl_list()
{
	system("ls /sys/class/leds");
}
