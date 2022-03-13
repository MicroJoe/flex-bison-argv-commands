// SPDX-FileCopyrightText: 2022 Agathe Porte <microjoe@microjoe.org>
//
// SPDX-License-Identifier: MIT

#ifndef LEDCTL_H
#define LEDCTL_H

struct arguments
{
	int argc, arg;
	char **argv;
};

int nextargument(struct arguments *args);

#endif /* LEDCTL_H */
