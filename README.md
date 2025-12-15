# DeviceBox

DeviceBox is an enterprise-grade container solution for running Android devices.
Unlike other wrappers, DeviceBox is built from scratch to prioritize stability and SELinux compatibility (RHEL/Rocky/Alma).

## Prerequisites

* **Docker** installed.
* **KVM Support:** The host machine must support hardware virtualization (KVM).
    * *Linux:* Ensure `/dev/kvm` exists.
    * *Windows:* See the WSL section below.

## Quick Start

```sh
# Pull the image
docker pull sergeygrishuk/devicebox:latest

# Run the container
docker run -d \
  -p 6080:6080 \
  --device /dev/kvm \
  --name DeviceBox \
  sergeygrishuk/devicebox:latest
```

**Accessing the Device:** Open your browser and navigate to `http://localhost:6080` to view the Android interface via noVNC.

## Building from Source

1. Build:

```sh
./build-container.sh
```

2. Run:

```sh
./run-container.sh
```

3. Access VNC via `localhost:6080`

### Running on WSL (Windows 11 Only)

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


# Roadmap & Compatibility

Supported OSs:
- [ ] RHEL based
    - [x] RHEL
    - [X] Rocky Linux
    - [ ] Alma Linux
- [ ] Debian Based
    - [ ] Debian
    - [x] Ubuntu
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
