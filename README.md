# DeviceBox

DeviceBox is an enterprise-grade container solution for running hardware-accelerated Android environments.

Most Android-in-Docker solutions are fragile wrappers around existing tools that break under strict security policies. DeviceBox is built from scratch to function reliably in hardened enterprise environments, specifically targeting **SELinux-enforced systems** (RHEL, Rocky, AlmaLinux).

It utilizes KVM for near-native performance and provides a clean, headless environment ideal for:
* **CI/CD Pipelines:** Reliable integration testing without flaky emulators.
* **Automated QA:** Seamless ADB and Appium support.
* **Security Research:** A consistent, sandboxed Android environment.

## Prerequisites

* **Docker** installed.
* **KVM Support:** The host machine must support hardware virtualization (KVM).
    * *Linux:* Ensure `/dev/kvm` exists.
    * *Windows:* See the WSL section below.

## Quick Start

1. Pull DeviceBox.

```sh
docker pull sergeygrishuk/devicebox:15
```

2. Run DeviceBox.

```sh
docker run -d \
  -p 6080:6080 \
  -p 5555:5555 \
  -e DEVICE="pixel" \
  --device /dev/kvm \
  --name DeviceBox \
  sergeygrishuk/devicebox:15
```

**Accessing the Device:** Open your browser and navigate to `http://localhost:6080` to view the Android interface via noVNC.


## Image Tags & Versions

DeviceBox uses Docker tags to specify the desired Android version.
The tag format corresponds directly to the Android version: `sergeygrishuk/devicebox:<android_version>`.

**Examples:**

* **Android 14:** `sergeygrishuk/devicebox:15`
* **Android 9:** `sergeygrishuk/devicebox:9`

**Currently available versions:** 9, 10, 11, 12, 12L, 13, 14, 15

To pull a specific version, simply adjust the tag in your pull command:

```sh
# Pull Android 9
docker pull sergeygrishuk/devicebox:9
```


## Device Profiles

By default, DeviceBox runs a generic device configuration. You can emulate specific hardware profiles (screen resolution, pixel density, and model properties) by setting the `DEVICE` environment variable.

**Usage:**
Add `-e DEVICE="<device_name>"` to your Docker run command.

**Example (Running a Pixel 6 Pro):**
```sh
docker run -d \
  -p 6080:6080 \
  -e DEVICE="pixel_6_pro" \
  --device /dev/kvm \
  --name DeviceBox \
  sergeygrishuk/devicebox:15
```

**Available Devices:** For the full list of supported device names, please refer to [Supported_Devices.md](Supported_Devices.md).

## Using ADB

To access the device via ADB add `-p 5555:5555` to the run command and connect via ADB.

1. Run the container with access to the adb port.

```sh
docker run -d \
  -p 6080:6080 \
  -p 5555:5555 \
  --device /dev/kvm \
  --name DeviceBox \
  sergeygrishuk/devicebox:14
```

2. Connect with `adb`.

```sh
adb connect localhost:5555
```

3. Once `adb` connected, you can access the device.

```sh
adb shell
```


## Running with SELinux

To run DeviceBox on systems with SELinux (RHEL/Rocky/Alma) add an SELinux policy as shown below.  
For more information see this [Wiki page](https://github.com/SergeyGrishuk/DeviceBox/wiki/Running-on-RHEL-Rocky-Alma-with-SELinux).

1. Install the `checkpolicy` package.

```sh
dnf install checkpolicy
```

2. Run the `apply-policy.sh` script to apply the SELinux policy.

```sh
bash selinux/apply-policy.sh
```


## Building from Source

1. Build:

```sh
./build-container.sh ANDROID_VERSION
```

2. Run:

```sh
./run-container.sh ANDROID_VERSION DEVICE
```

3. Access VNC via `http://localhost:6080`

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


# Roadmap & Compatibility

Supported OSs:
- [x] RHEL based
    - [x] RHEL
    - [x] Rocky Linux
    - [x] Alma Linux
- [x] Debian Based
    - [x] Debian
    - [x] Ubuntu
- [x] Windows (WSL)
- [ ] OSx

Supported Android Versions (API Levels):
- [x] Android 9 (API Level 28)
- [x] Android 10 (API Level 29)
- [x] Android 11 (API Level 30)
- [x] Android 12 (API Level 31)
- [x] Android 12L (API Level 32)
- [x] Android 13 (API Level 33)
- [x] Android 14 (API Level 34)
- [x] Android 15 (API Level 35)
- [ ] Android 16 (API Level 36)

Features:
- [x] VNC (Visual access)
- [x] ADB
- [x] Devices
- [ ] Appium
- [ ] Persistent Storage
- [ ] Screen Recording
- [ ] Proxy Support
