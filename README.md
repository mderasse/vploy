# vPloy

**Current State:** Under active development (but usable)

vPloy is an application that combine some of the most famous Infrastructure As Code tools in order to deploy a full infrastructure on a VMware vSphere system.

vPloy is currently using the following tools:
 - [Ansible](https://www.ansible.com/)
 - [AWX](https://github.com/ansible/awx)
 - [Packer](https://www.packer.io/)
 - [Packer vSphere](https://github.com/jetbrains-infra/packer-builder-vsphere)
 - [Terraform](https://www.terraform.io/)

It will automatically :
 - Bootstrap your vSphere
 - Create a Debian and Ubuntu Template
 - Deploy a Management Gateway
 - Deploy a Bastion
 - Deploy an AWX server
 - And More ....

## Objectives
The goal of vPloy is to help the deployment of an Infrastructure as Code on a VMware vSphere Infrastructure.

vPloy has been develop to be easily customizable and make that new infrastructure easy to be maintained, scale, ...

## Getting Started

## Configuration

## Customization

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/mderasse/vploy/tags). 

## Authors

* **Matthieu DERASSE** - *Initial work* - [mderasse](https://github.com/mderasse)

See also the list of [contributors](https://github.com/mderasse/vploy/contributors) who participated in this project.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE.md](LICENSE.md) file for details

## Quick reference

#### Where to get help

[Github Issues Tracker](https://github.com/mderasse/vploy/issues)

#### Where to file issues

[Github issues Tracker](https://github.com/mderasse/vploy/issues)

## Acknowledgments

* OVHcloud for their [Hosted Private Cloud](https://www.ovh.com/fr/private-cloud/) used for the development of vPloy.
* [marema31](https://github.com/marema31), [HLerman](https://github.com/HLerman) for their comments and ideas.