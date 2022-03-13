<!--
SPDX-FileCopyrightText: 2022 Agathe Porte <microjoe@microjoe.org>

SPDX-License-Identifier: MIT
-->

# Flex/Bison argv command parser

A small experiment with Flex and Bison to parse argv arguments into a grammar,
and execute (fake) commands accordingly.

## Notes

The program was named `ledctl` because it could be expanded to write a small
tool to modify led status of any system without having to manually `echo`
desired status into the corresponding sysfs files.

## Example

```console
$ ./ledctl led on   
echo 1 > /dev/led

$ ./ledctl power on
echo 1 > /dev/power

$ ./ledctl led blink
echo blink > /dev/led

$ ./ledctl power blink
error: syntax error
```

## License

This software is licensed under the [MIT license](LICENSES/MIT.txt).
