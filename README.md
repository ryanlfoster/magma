Magma
=====

![magma-graphic](https://cloud.githubusercontent.com/assets/2628905/7764595/206d5a9a-0019-11e5-827d-61c15995cd02.jpg)


Magma was created to allow developers an easy way to get Ruby & Rails applications up and running quickly in a development environment. Magma is a prepackaged basebox that comes with everything you need to get started. It is disposable and lightweight without the worries of altering your operating system. Just grab a copy and `vagrant up` to get going.

## Included Software
- Ubuntu 14.04
- Nginx
- MySQL
- Ruby
- Rails
- Passenger
- Node

## Installation & Setup

### VirtualBox & Vagrant
For **Magma** to work you must have [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) installed. Both of these software packages are free! Head on over to their websites and download a copy and install before continuing.

### Adding The Vagrant Basebox
To make installation as easy as possible a vagrant `basebox` has already been created for you! You just have to add this to your system. The first download is the longest. After that, you won't have to do this except for updates! Run this command to add the box to your system.

```
vagrant box add rossedman/magma
```

### Clone The Repository
Once your box is installed you only need the files contained in this repository to make it work. Clone this repository near your code repos as it will be the central environment for your ruby apps.

```
git clone https://github.com/rossedman/magma.git ~/Sites/Magma
```

### Setting SSH Key
Next edit the `Magma.yaml` file that is contained in this repository. In this file, you can configure the path to your public SSH key, as well as the folders you wish to be shared between your main machine and the Homestead virtual machine.

### Configure Shared Folders
The `folders` property of the `Magma.yaml` file lists all of the folders you wish to share with your Magma environment. As files within these folders are changed, they will be kept in sync between your local machine and the Magma environment. You may configure as many shared folders as necessary!

### Enable Sites
The `sites` property allows you to easily map a "domain" to a folder on your Magma environment. A sample site configuration is included in the Homestead.yaml file. Add as many sites as you want! Most of the time these will map to a `public` folder inside of your Ruby apps

### Add Sites To Hosts File
Don't forget to register your sites with your local computer's host file! To do this run `sudo nano /etc/hosts` and add an entry for each site like this: `127.0.0.1   magma.app`. This will make the site accessible to the browser on your computer. On Windows, it is located at `C:\Windows\System32\drivers\etc\hosts`. The lines you add to this file will look like the following: `192.168.10.30  magma.app`

### Bash Aliases
To add Bash aliases to Magma, simply add to the aliases file in the root of the Magma directory. These can be anything you would like to make your development process easier. An alias of `magma` has been provided as an example in the `aliases` file. After logging in, if you type `magma` it will immediately iniatate a new Rails application!

## Launching Environment
Once you have edited `Magma.yaml` file to fit your environment needs run `vagrant up` in the folder that this repo was cloned to. The virtual machine will be booted up! Once it is is done booting up run `vagrant ssh` to log in to the box.

## Usage
### Connect To MySQL
To connect to your MySQL database from your main machine via Navicat or Sequel Pro, you should connect to `127.0.0.1` and port `33666`. The username and password for MySQL is `magma` / `secret`.
