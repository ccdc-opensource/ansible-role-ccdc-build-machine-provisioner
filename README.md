# Introduction 

This ansible role will set up a target machine with the prerequisites for creating all three stages of CCDC build machines.

For detailed documentation on CCDC build machine provisioning, please visit [the documentation on Confluence](https://confluence.ccdc.cam.ac.uk/x/6Rh_/).

# Requirements

You will need to have access to the [CCDC Azure DevOps `build_systems` repositories](https://dev.azure.com/ccdc/build-systems/).

In order to set up the VMware related licenses correctly, you *must* set the following environment variables:

  - `CCDC_VAGRANT_VMWARE_PLUGIN_LICENSE_FILE` to the path of a licence file for the Vagrant VMware Plugin
  - `CCDC_VMWARE_LICENSE_KEY` to the license key for VMware Fusion/Workstation

If these variables are not set, you will NOT be able to build VMware images after provisioning.

# Manual Steps Required

On MacOS hosts, VirtualBox and VMWare will likely both need their kernel extensions activating before they can be used properly. To do this, open System Preferences, navigate to the Security & Privacy pane and click the lock icon on the "General" tab. There should be a message notifying you of the kernel extensions having been blocked, which you can allow from this tab in the dialog.

# Details

In detail, this will install:

  - [Packer](https://packer.io)
  - [Vagrant](https://vagrantup.com/)
  - [Vagrant VMware Utility](https://www.vagrantup.com/vmware/) and the required plugin
  - [VirtualBox](https://virtualbox.org/)
  - [VMWare Fusion](https://www.vmware.com/products/fusion.html) (on macOS)
  - [VMWare Workstation Pro](https://www.vmware.com/products/workstation-pro.html) (on Linux and Windows)
  - [Ansible](https://www.ansible.com/)

On macOS only, applying the role will also download:

  - [macinbox](https://github.com/bacongravy/macinbox) (required for creating stage 1 base boxes)
  - A recent macOS installer (used by macinbox to create stage 1 base boxes)

On Windows only, the role will also install and set up the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) Ubuntu distribution as this is the only way to use the provisioning tools on Windows.

It will also download all the deployment roles from the CCDC Azure repositories and apply licenses to VMware and the Vagrant VMware Utility.

The deployment roles will be downloaded to the following locations on the different systems:

  - `d:\ccdc-provisioning` on Windows
  - `/Users/vagrant/ccdc-provisioning` on macOS
  - `/home/vagrant/ccdc-provisioning` on Linux
