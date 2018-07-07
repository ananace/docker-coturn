# A simple coturn container image

Designed for use in K8s, with simplified access to the downwards API through environment expansion in the config file


### Configuration

The launch script will run a shell variable expansion pass on your configuration file, which means values that need to contain literal `$`-signs will have to be escaped.

### Environment variables

If you don't want / need a full configuration file, you can also set a handful of environment variabls to configure common features;

- `EXTERNAL_IP` - Sets `external-ip` in the config.
- `INTERNAL_IP` - TOnly used if `EXTERNAL_IP` is also set, also used for `external-ip`.
- `PORT` - Sets the `listening-port` directive.
- `MIN_PORT` - Sets the `min-port` directive.
- `MAX_PORT` - Sets the `max-port` directive.
- `AUTH_SECRET` - Enables and configures secret-based auth in the config, sets; `lt-cred-mech`, `use-auth-secret`, and `static-auth-secret`.
- `REALM` - Sets the `realm` directive.
- `EXTRA_CONFIG` - Allows you to add a block of text that's added directly to the config file.
