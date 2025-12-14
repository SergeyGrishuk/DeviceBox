# DeviceBox
DeviceBox is an enterprise ready solution for Android containers.

*The projects is in an early stage of development and updates are to be expected.*

# Usage

1. Build the container:

```sh
./build-container.sh
```

2. Run the container:

```sh
./run-container.sh
```

3. Access VNC via `localhost:6080`

## Running on WSL (Windows 11 Only)

Add the user to the `kvm` group:

```sh
sudo usermod -a -G kvm ${USER}
```

Modify the `/etc/wsl.conf` file:

```conf
[boot]
command = /bin/bash -c 'chown -v root:kvm /dev/kvm && chmod 660 /dev/kvm'

[wsl2]
nestedVirtualization=true
```

Restart WSL:

```ps
wsl --shutdown
```


# Project Roadmap

Supported OSs:
- [ ] RHEL based
    - [ ] RHEL
    - [ ] Rocky Linux
    - [ ] Alma Linux
- [ ] Debian Based
    - [ ] Debian
    - [ ] Ubuntu
- [x] Windows (WSL)
- [ ] OSx

Supported Android Versions (API Levels):
- [x] Android 14 (API Level 34)
- [ ] Android 13 (API Level 33)
- [ ] Android 15 (API Level 35)
- [ ] Android 16 (API Level 36)
- [ ] Android 12 (API Level 31)
- [ ] Android 12L (API Level 32)
- [ ] Android 11 (API Level 30)
- [ ] Android 10 (API Level 29)

Features:
- [x] VNC (for visibility)
- [ ] ADB
- [ ] Appium
- [ ] Screen Recording
- [ ] Proxy Support
