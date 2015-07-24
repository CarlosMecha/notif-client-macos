
# Notifications client for MacOS

This is a tiny command line client for pulling notifications from
a notifications service (currently using [www.github.com/CarlosMecha/notifications](this)).

## Author

Carlos Mecha, 2015

- Version 0.1: Developed from 07/13/2015 and released on 07/17/2015.
- Version 0.5: Developed from 07/20/2015 and released on 07/24/2015.

## Run it

Compile using XCode 6. Next versions will provide an script or binaries.

```
./NotifClientMacOS [-g] <url>/[<topic>]
```

The option `-g` activates the graphical component, that calls the Notification Center for
each received notification.

The payloads should contain a `text` field with the description of the notification.

## Tests

TODO.

## Contribute

These tiny pieces of code (notifications, mqlite, etc) are ideas or prototypes developed in
~6 hours. If you find this code useful, feel free to do whatever you want with it. Help/ideas/bug
reporting are also welcome.

Thanks!

